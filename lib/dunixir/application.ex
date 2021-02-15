defmodule Dunixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Dunixir.Worker.start_link(arg)
      # {Dunixir.Worker, arg}
      BDD.Create,
      Plug.Adapters.Cowboy.child_spec(
        scheme: :http,
        plug: ServerHttp.Router,
        options: [port: 8085]
      )
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dunixir.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
