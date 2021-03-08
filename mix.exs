defmodule Dunixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :dunixir,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:crypto, :inets, :logger, :plug, :cowboy, :poison],
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

      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 1.5"},
      {:poison, "~> 3.1"},
      {:plug_cowboy, "~> 1.0"},
      {:json, "~> 1.4"},
      {:ymlr, "~> 1.0"},
      {:ex2ms, "~> 1.0"},
      {:elixir_uuid, "~> 1.2"},
      {:socket, "~> 0.3.13"},
    ]
  end
end
