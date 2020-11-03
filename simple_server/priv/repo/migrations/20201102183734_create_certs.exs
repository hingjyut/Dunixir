defmodule Duniter.Repo.Migrations.CreateCerts do
  use Ecto.Migration

  def change do
    create table(:certifications) do
      add :uid, :string
      add :pubkey, :string
      add :from_pubkey, :string
      add :written, :boolean
    end
  end
end
