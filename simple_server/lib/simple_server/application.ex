defmodule SimpleServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: SimpleServer.Worker.start_link(arg)
      # {SimpleServer.Worker, arg}
      Plug.Adapters.Cowboy.child_spec(scheme: :http, plug: SimpleServer.Router, options: [port: 8085]),
      Repo,
      %{id: Restarter, start: {Restarter, :start, []}},
      {DynamicSupervisor, strategy: :one_for_one, name: Identity.DynamicSupervisor,max_restarts: 1000,restart: :transient}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SimpleServer.Supervisor]
    Supervisor.start_link(children, opts)
    #pid = spawn(fn -> start_id_genservers() end)
    #{:ok,pid}
  end


end
