defmodule Repo.Migrations.CreateLocalSIndex do
  use Ecto.Migration

  def change do
    create table(:local_s_index) do
      add :op, :string
      add :tx, :string
      add :identifier, :string
      add :pos, :integer
      add :created_on, :string
      add :amount, :integer
      add :base, :integer
      add :locktime, :integer
      add :consumed, :boolean
      add :conditions, :string
      add :written_on, :integer
    end
    create unique_index(:local_s_index, [:op,:identifier,:pos])
  end
  
end
