defmodule WS2P.Connection do
  use GenServer, restart: :transient
  require Logger

  @keypair Ed25519.generate_key_pair()
  @currency_name "g1-test"

  def start_link({:connect, address_and_port, socket_options}) do
    GenServer.start_link(__MODULE__, {:connect, address_and_port, socket_options},
      name: {:via, Registry, {WS2P.Connection.Registry, address_and_port}}
    )
  end

  def start_link({:accept, socket}) do
    address_and_port = Socket.Web.remote!(socket)

    GenServer.start_link(__MODULE__, {:accept, address_and_port, socket},
      name: {:via, Registry, {WS2P.Connection.Registry, address_and_port}}
    )
  end

  def init({:connect, address_and_port, socket_options}) do
    socket = Socket.Web.connect!(address_and_port, socket_options)
    Logger.info("Connected socket to #{inspect(address_and_port)}")
    schedule_poll_remote_packets()

    {:ok,
     %{
       socket: socket,
       keypair: @keypair,
       currency_name: @currency_name,
       address_and_port: address_and_port
     }, {:continue, :send_connect_object}}
  end

  def init({:accept, address_and_port, socket}) do
    Logger.info("Accepted socket from #{inspect(address_and_port)}")
    schedule_poll_remote_packets()

    {:ok,
     %{
       socket: socket,
       keypair: @keypair,
       currency_name: @currency_name,
       address_and_port: address_and_port
     }, {:continue, :send_connect_object}}
  end

  def handle_continue(
        :send_connect_object,
        %{
          address_and_port: address_and_port,
          keypair: {sec, pub},
          currency_name: currency_name
        } = state
      ) do
    local_challenge = UUID.uuid4() <> UUID.uuid4()
    pub_as_base58 = pub |> Base58.encode()
    raw_format = "WS2P:CONNECT:#{currency_name}:#{pub_as_base58}:#{local_challenge}"
    signature = Ed25519.signature(raw_format, sec, pub)

    connect_object = %{
      "auth" => "CONNECT",
      "pub" => pub_as_base58,
      "challenge" => local_challenge,
      "sig" => signature |> Base.encode64()
    }

    Logger.info("Sending CONNECT to node #{inspect(address_and_port)}\n#{raw_format}")
    handle_local_object(connect_object, Map.put_new(state, :local_challenge, local_challenge))
  end

  defp schedule_poll_remote_packets do
    Process.send_after(self(), :poll_remote_packets, 1000)
  end

  def handle_info(:poll_remote_packets, %{socket: socket} = state) do
    poll_remote_packets(socket)
    |> Enum.map(fn packet ->
      GenServer.cast(self(), {:remote_packet, packet})
    end)

    schedule_poll_remote_packets()
    {:noreply, state}
  end

  defp poll_remote_packets(socket, remote_packets \\ []) do
    case Socket.Web.recv(socket, timeout: 0) do
      {:ok, packet} ->
        poll_remote_packets(socket, [packet | remote_packets])

      {:error, :timeout} ->
        remote_packets

      {:error, code} ->
        Logger.error(code)
        raise Socket.Error, reason: code
    end
  end

  defp handle_local_packet(packet, %{socket: socket} = state) do
    Socket.Web.send!(socket, packet)
    {:noreply, state}
  end

  defp handle_local_msg(msg, state) do
    handle_local_packet({:text, msg}, state)
  end

  defp handle_local_object(object, state) do
    msg = Poison.encode!(object, pretty: true)
    handle_local_msg(msg, state)
  end

  def handle_cast({:local_msg, msg}, state) do
    handle_local_msg(msg, state)
  end

  def handle_cast({:local_object, object}, state) do
    handle_local_object(object, state)
  end

  def handle_cast({:remote_packet, packet}, state) do
    handle_remote_packet(packet, state)
  end

  defp handle_remote_object(
         %{
           "auth" => "CONNECT",
           "challenge" => challenge,
           "pub" => _pub,
           "sig" => _sig
         },
         %{
           keypair: {my_sec, my_pub},
           currency_name: currency_name,
           address_and_port: address_and_port
         } = state
       ) do
    Logger.info("Received CONNECT from node #{inspect(address_and_port)}")

    my_pub_as_base58 = my_pub |> Base58.encode()
    raw_format = "WS2P:ACK:#{currency_name}:#{my_pub_as_base58}:#{challenge}"
    signature = Ed25519.signature(raw_format, my_sec, my_pub)

    ack_object = %{
      "auth" => "ACK",
      "pub" => my_pub_as_base58,
      "sig" => signature |> Base.encode64()
    }

    Logger.info("Sending ACK to node #{inspect(address_and_port)}\n#{raw_format}")
    handle_local_object(ack_object, state)
  end

  defp handle_remote_object(
         %{
           "auth" => "ACK",
           "pub" => _pub,
           "sig" => _sig
         },
         %{
           keypair: {my_sec, my_pub},
           currency_name: currency_name,
           local_challenge: local_challenge,
           address_and_port: address_and_port
         } = state
       ) do
    Logger.info("Received ACK from node #{inspect(address_and_port)}")

    my_pub_as_base58 = my_pub |> Base58.encode()
    raw_format = "WS2P:OK:#{currency_name}:#{my_pub_as_base58}:#{local_challenge}"
    signature = Ed25519.signature(raw_format, my_sec, my_pub)

    ok_object = %{
      "auth" => "OK",
      "sig" => signature |> Base.encode64()
    }

    Logger.info("Sent OK to node #{inspect(address_and_port)}\n#{raw_format}")
    handle_local_object(ok_object, state)
  end

  defp handle_remote_object(
         %{
           "auth" => "OK",
           "sig" => _sig
         },
         %{
           address_and_port: address_and_port
         } = state
       ) do
    Logger.info("Received OK from node #{inspect(address_and_port)}")
    {:noreply, state}
  end

  defp handle_remote_object(object, state) do
    IO.puts("Received unhandled remote object:")
    IO.inspect(object)
    {:noreply, state}
  end

  defp handle_remote_packet({:text, msg}, state) do
    case Poison.decode(msg) do
      {:ok, object} ->
        handle_remote_object(object, state)

      {:error, error} ->
        Logger.warn("Could not decode message:\n#{inspect(error, pretty_print: true)}")
        {:noreply, state}
    end
  end

  defp handle_remote_packet({type, msg}, %{socket: socket} = state) do
    Logger.debug("Received message of type #{inspect(type)} from #{socket.origin}:\n#{msg}")
    {:noreply, state}
  end

  defp handle_remote_packet(:close, %{socket: socket, address_and_port: address_and_port} = state) do
    Logger.info("Remote #{inspect(address_and_port)} closed socket connection")
    Socket.Web.close(socket)
    {:stop, :shutdown, state}
  end

  defp handle_remote_packet(
         {:close, code, reason},
         %{socket: socket, address_and_port: address_and_port} = state
       ) do
    Logger.debug(
      "Remote #{inspect(address_and_port)} closed socket connection with code \"#{code}\""
    )

    Logger.debug("Reason: \"#{reason}\"")
    Socket.Web.close(socket)
    {:stop, :shutdown, state}
  end
end
