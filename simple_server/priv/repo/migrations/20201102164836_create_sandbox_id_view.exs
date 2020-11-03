defmodule Duniter.Repo.Migrations.CreateSandboxIdView do
  use Ecto.Migration

  def change do
    execute("""
    CREATE VIEW sandbox_idty AS SELECT * FROM identities WHERE identities.member = false;
    """)
  end
end
