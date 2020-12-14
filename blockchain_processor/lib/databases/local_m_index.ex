defmodule LocalMIndex do
  use Ecto.Schema

  schema "local_m_index" do
    field :op, :string
    field :pub, :string
    field :created_on, :string
    field :written_on, :string
    field :expires_on, :integer
    field :expired_on, :integer
    field :revokes_on, :integer
    field :revoked_on, :integer
    field :leaving, :boolean
    field :revocation, :string
    field :chainable_on, :integer
  end

  def changeset(id, params \\ %{}) do
    id
    |> Ecto.Changeset.cast(params, [:op, :pub, :created_on, :written_on, :expires_on, :expired_on, :revokes_on, :revoked_on, :leaving, :revocation, :chainable_on])
    |> Ecto.Changeset.validate_required([:op, :pub, :written_on])
    |> Ecto.Changeset.unique_constraint(:pub)
  end
end

