defmodule Repo.Migrations.CreateLocalIindex do
  use Ecto.Migration

  def change do
    create table(:local_i_index) do
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
    create unique_index(:local_i_index, [:uid]) 
    create unique_index(:local_i_index, [:pub])
  end
end
