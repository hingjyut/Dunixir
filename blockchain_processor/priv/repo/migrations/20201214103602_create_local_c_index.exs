defmodule Repo.Migrations.CreateLocalCIndex do
  use Ecto.Migration

  def change do
    create table(:local_c_index) do
      add :op, :string
      add :issuer, :string
      add :receiver, :string
      add :created_on, :integer
      add :written_on, :string
      add :sig, :string
      add :expires_on, :integer
      add :expired_on, :integer
      add :chainable_on, :integer
      add :replayable_on, :integer
      
    end
    create unique_index(:local_c_index, [:issuer])
  end
end
