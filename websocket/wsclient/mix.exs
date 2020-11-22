defmodule ClientWs.MixProject do
  use Mix.Project

  def project do
    [
      app: :client_ws,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:websockex],
      mod: {ClientWs, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:websockex, "~>0.4.2"},
      {:jason, "~> 1.1"}
    ]
  end
end
