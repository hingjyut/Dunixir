defmodule Repo.Migrations.CreateLocalMIndex do
  use Ecto.Migration

  def change do
    create table(:local_m_index) do
      add :op, :string
      add :pub, :string
      add :created_on, :string
      add :written_on, :string
      add :expires_on, :integer
      add :expired_on, :integer
      add :revokes_on, :integer
      add :revoked_on, :string
      add :leaving, :boolean
      add :revocation, :string
      add :chainable_on, :integer
    end
    create unique_index(:local_m_index, [:pub])
  end
end
