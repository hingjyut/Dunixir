defmodule Repo.Migrations.CreateIindex do
  use Ecto.Migration

  def change do
    create table(:i_index) do
      add :op, :string
      add :uid, :string
      add :pub, :string
      add :hash, :string
      add :sig, :string
      add :created_on, :string
      add :written_on, :string
      add :member, :boolean
      add :was_member, :boolean
      add :kick, :boolean
    end
    create unique_index(:i_index, [:uid])
    create unique_index(:i_index, [:pub])
  end
end
