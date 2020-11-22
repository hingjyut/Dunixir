defmodule TestWs do
  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: TestWs.Router,
        options: [
          dispatch: dispatch(),
          port: 4000
        ]
      ),
      Registry.child_spec(
        keys: :duplicate,
        name: Registry.TestWs
      )
    ]
    opts = [strategy: :one_for_one, name: TestWs.Application]
    Supervisor.start_link(children, opts)
  end

  defp dispatch do
    [
      {:_,
        [
          {"/ws/[...]", TestWs.SocketHandler, []}
        ]
      }
    ]
  end
end
