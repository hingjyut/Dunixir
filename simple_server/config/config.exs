import Config

config :simple_server, Repo,
  database: "simple_server_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

###use mix.ecto commands in cli.
config :simple_server, ecto_repos: [Repo]
