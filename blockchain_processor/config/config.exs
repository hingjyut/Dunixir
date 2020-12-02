import Config

config :blockchain_processor, Repo,
  database: "blockchain_processor_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :blockchain_processor, ecto_repos: [Repo]
