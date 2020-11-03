defmodule Duniter.Repo.Migrations.CreateIds do
  use Ecto.Migration

  def change do
    create table(:identities) do
      add :uid, :string
      add :pubkey, :string
      add :member, :boolean
    end
  end
end
