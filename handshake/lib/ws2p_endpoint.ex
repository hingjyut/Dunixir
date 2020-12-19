defmodule WS2P.Endpoint do
  require Logger

  @keypair Ed25519.generate_key_pair()
  @currency_name "g1"

  defp start_connection!(args) do
    {:ok, connection} =
      DynamicSupervisor.start_child(
        WS2P.ConnectionSupervisor,
        {WS2P.Connection, args}
      )

    {:ok, _task_pid} =
      Task.Supervisor.start_child(WS2P.TaskSupervisor, fn ->
        WS2P.Connection.start_handshake_and_loop(connection, @keypair, @currency_name)
      end)

    connection
  end

  def connect!({address, port}, path) do
    start_connection!({:connect, {address, port}, path})
  end

  def accept_connections!(port, path) do
    websocket_listener = Socket.Web.listen!(port)
    Logger.info("Listening for websocket connections on port #{port} at #{path}")

    {_sec, pub} = @keypair
    Logger.info("Public key: #{pub |> Base58.encode()}")
    loop_acceptor!(websocket_listener, path)
  end

  defp loop_acceptor!(websocket_listener, path) do
    client_socket = Socket.Web.accept!(websocket_listener)

    if client_socket.path == path do
      start_connection!({:accept, client_socket})
    end

    loop_acceptor!(websocket_listener, path)
  end
end
