defmodule Duniter.Repo.Migrations.CreateIds do
  use Ecto.Migration

  def change do
    create table(:identities) do
      add :uid, :string
      add :pubkey, :string
      add :member, :boolean
    end
    create unique_index(:identities, [:uid])
    create unique_index(:identities, [:pubkey])
  end
end
