defmodule Dunixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :dunixir,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :inets],
      mod: {Dunixir.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:B58, "~> 1.0", hex: :b58},
      {:ed25519, "~> 1.3"},
      {:scrypt_elixir, "~> 0.1.0"},
      {:enacl, "~> 1.1"},
      {:ymlr, "~> 1.0"}
    ]
  end
end
