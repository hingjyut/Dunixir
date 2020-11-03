defmodule Duniter.Repo.Migrations.CreateSandboxCerts do
  use Ecto.Migration

  def change do
    execute("""
    CREATE VIEW sandbox_certs AS SELECT * FROM certifications WHERE certifications.written = false;
    """)
  end
end
