defmodule Repo do
  use Ecto.Repo,
    otp_app: :blockchain_processor,
    adapter: Ecto.Adapters.Postgres
end
