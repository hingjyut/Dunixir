defmodule MyWebsocketApp do
  use Application

  def start(_type, _args) do
    port = String.to_integer(System.get_env("PORT") || "20900")

    children = [
      {Registry, keys: :unique, name: WS2P.Connection.Registry},
      {DynamicSupervisor, strategy: :one_for_one, name: WS2P.ConnectionSupervisor},
      {Task, fn -> WS2P.Endpoint.accept_connections!(port, "/") end}
    ]

    opts = [strategy: :one_for_one, name: MyWebsocketApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
