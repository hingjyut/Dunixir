defmodule Dunixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    ws2p_port = String.to_integer(System.get_env("WS2P_PORT") || "20900")
    http_port = String.to_integer(System.get_env("HTTP_PORT") || "8085")

    children = [
      # Starts a worker by calling: Dunixir.Worker.start_link(arg)
      # {Dunixir.Worker, arg}
      BDD.Create,
      Plug.Adapters.Cowboy.child_spec(scheme: :http, plug: ServerHttp.Router, options: [port: http_port]),
      {Registry, keys: :unique, name: WS2P.Connection.Registry},
      {DynamicSupervisor, strategy: :one_for_one, name: WS2P.ConnectionSupervisor},
      WS2P.Cluster,
      {Task, fn -> WS2P.Endpoint.accept_connections!(ws2p_port, "/") end}
     ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dunixir.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
