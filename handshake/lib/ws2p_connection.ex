defmodule WS2P.Connection do
  use GenServer, restart: :transient
  require Logger

  def start_link({:connect, address_and_port, socket_options}) do
    GenServer.start_link(__MODULE__, {:connect, address_and_port, socket_options},
      name: {:via, Registry, {WS2P.Connection.Registry, address_and_port}}
    )
  end

  def start_link({:accept, socket}) do
    GenServer.start_link(__MODULE__, {:accept, socket},
      name: {:via, Registry, {WS2P.Connection.Registry, Socket.Web.remote!(socket)}}
    )
  end

  def init({:connect, {address, port}, socket_options}) do
    socket = Socket.Web.connect!({address, port}, socket_options)
    Logger.info("Connected socket to #{address}:#{port}")
    {:ok, %{socket: socket}}
  end

  def init({:accept, socket}) do
    Socket.Web.accept!(socket)
    Logger.info("Accepted socket from #{socket.origin}")
    {:ok, %{socket: socket}}
  end

  def start_handshake_and_loop(connection, keypair, currency_name) do
    connection
    |> send_connect(keypair, currency_name)
    |> loop()
  end

  defp loop(connection) do
    case connection |> WS2P.Connection.receive_object() do
      {_object, :answer, answer} ->
        connection |> WS2P.Connection.send_object(answer)

      _ ->
        {}
    end

    loop(connection)
  end

  def handle_object(
        %{
          "auth" => "OK",
          "sig" => _sig
        } = ok_object,
        %{
          socket: socket
        } = state
      ) do
    Logger.info("Received OK from node #{inspect(Socket.Web.remote!(socket))}")
    {:reply, {ok_object, :noanswer}, state}
  end

  def handle_object(
        %{
          "auth" => "ACK",
          "pub" => _pub,
          "sig" => _sig
        } = ack_object,
        %{
          socket: socket,
          keypair: {my_sec, my_pub},
          currency_name: currency_name,
          local_challenge: local_challenge
        } = state
      ) do
    Logger.info("Received ACK from node #{inspect(Socket.Web.remote!(socket))}")

    my_pub_as_base58 = my_pub |> Base58.encode()
    raw_format = "WS2P:OK:#{currency_name}:#{my_pub_as_base58}:#{local_challenge}"
    signature = Ed25519.signature(raw_format, my_sec, my_pub)

    ok_object = %{
      "auth" => "OK",
      "sig" => signature |> Base.encode64()
    }

    Logger.info("Sent OK to node #{inspect(Socket.Web.remote!(socket))}\n#{raw_format}")
    {:reply, {ack_object, :answer, ok_object}, state}
  end

  def handle_object(
        %{
          "auth" => "CONNECT",
          "challenge" => challenge,
          "currency" => _currency,
          "pub" => _pub,
          "sig" => _sig
        } = connect_object,
        %{socket: socket, keypair: {my_sec, my_pub}, currency_name: currency_name} = state
      ) do
    Logger.info("Received CONNECT from node #{inspect(Socket.Web.remote!(socket))}")

    my_pub_as_base58 = my_pub |> Base58.encode()
    raw_format = "WS2P:ACK:#{currency_name}:#{my_pub_as_base58}:#{challenge}"
    signature = Ed25519.signature(raw_format, my_sec, my_pub)

    ack_object = %{
      "auth" => "ACK",
      "pub" => my_pub_as_base58,
      "sig" => signature |> Base.encode64()
    }

    Logger.info("Sent ACK to node #{inspect(Socket.Web.remote!(socket))}\n#{raw_format}")
    {:reply, {connect_object, :answer, ack_object}, state}
  end

  def handle_object(object, state) do
    IO.puts("Received unhandled object:")
    IO.inspect(object)
    {:reply, {object, :noanswer}, state}
  end

  def handle_packet(:close, %{socket: socket} = state) do
    Logger.info("Remote #{inspect(Socket.Web.remote!(socket))} closed socket connection")
    Socket.Web.close(socket)
    {:stop, :shutdown, state}
  end

  def handle_packet({:close, code, reason}, %{socket: socket} = state) do
    Logger.debug(
      "Remote #{inspect(Socket.Web.remote!(socket))} closed socket connection with code \"#{code}\""
    )

    Logger.debug("Reason: \"#{reason}\"")
    Socket.Web.close(socket)
    {:stop, :shutdown, state}
  end

  def handle_packet({:text, msg}, state) do
    case Poison.decode(msg) do
      {:ok, object} ->
        WS2P.Connection.handle_object(object, state)

      {:error, error} ->
        Logger.warn("Could not decode text message:\n#{inspect(error, pretty_print: true)}")
        {:reply, :noanwser, state}
    end
  end

  def handle_packet({type, msg}, %{socket: socket} = state) when type != :text do
    Logger.debug("Received message of type #{inspect(type)} from #{socket.origin}:\n#{msg}")
    {:reply, :noanswer, state}
  end

  def handle_call(:receive, _from, %{socket: socket} = state) do
    case socket |> Socket.Web.recv() do
      {:ok, packet} ->
        WS2P.Connection.handle_packet(packet, state)

      {:error, error} ->
        {:stop, error}
    end
  end

  def handle_cast({:send_packet, packet}, %{socket: socket} = state) do
    socket |> Socket.Web.send!(packet)
    {:noreply, state}
  end

  def handle_cast({:send_object, object}, state) do
    msg = Poison.encode!(object, pretty: true)
    handle_cast({:send_packet, {:text, msg}}, state)
  end

  def handle_cast(
        {:send_connect, {sec, pub} = keypair, currency_name},
        %{socket: socket} = state
      ) do
    challenge = UUID.uuid4() <> UUID.uuid4()
    pub_as_base58 = pub |> Base58.encode()
    raw_format = "WS2P:CONNECT:#{currency_name}:#{pub_as_base58}:#{challenge}"
    signature = Ed25519.signature(raw_format, sec, pub)

    connect_object = %{
      "auth" => "CONNECT",
      "pub" => pub_as_base58,
      "challenge" => challenge,
      "sig" => signature |> Base.encode64()
    }

    {:noreply, state} = handle_cast({:send_object, connect_object}, state)

    Logger.info("Sent CONNECT to node #{inspect(Socket.Web.remote!(socket))}\n#{raw_format}")

    new_state =
      Map.merge(state, %{
        local_challenge: challenge,
        keypair: keypair,
        currency_name: currency_name
      })

    {:noreply, new_state}
  end

  def receive_object(connection) do
    GenServer.call(connection, :receive, :infinity)
  end

  def send_object(connection, object) do
    connection |> GenServer.cast({:send_object, object})
    connection
  end

  def send_connect(connection, keypair, currency_name) do
    connection |> GenServer.cast({:send_connect, keypair, currency_name})
    connection
  end
end
