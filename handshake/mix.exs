defmodule MyWebsocketApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :my_websocket_app,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {MyWebsocketApp, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:socket, "~> 0.3.13"},
      {:poison, "~> 4.0"},
      {:elixir_uuid, "~> 1.2"},
      {:ed25519, "~> 1.3"},
      {:B58, "~> 1.0", hex: :b58}
    ]
  end
end
