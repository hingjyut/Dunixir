defmodule WS2P.Endpoint do
  require Logger

  defp start_connection!(args) do
    {:ok, connection} =
      DynamicSupervisor.start_child(
        WS2P.ConnectionSupervisor,
        {WS2P.Connection, args}
      )

    connection
  end

  def connect!(address_and_port, socket_options \\ []) do
    start_connection!({:connect, address_and_port, socket_options})
  end

  def accept_connections!(port, path) do
    websocket_listener = Socket.Web.listen!(port)
    Logger.info("Listening for websocket connections on port #{port} at #{path}")
    loop(websocket_listener, path)
  end

  defp loop(websocket_listener, path) do
    client_socket = Socket.Web.accept!(websocket_listener)
    if client_socket.path == path do
      start_connection!({:accept, client_socket})
    end

    loop(websocket_listener, path)
  end
end
