defmodule LocalCIndex do
  use Ecto.Schema

  schema "local_c_index" do
    field :op, :string
    field :issuer, :string
    field :receiver, :string
    field :created_on, :integer
    field :written_on, :string
    field :sig, :string
    field :expires_on, :integer
    field :expired_on, :integer
    field :chainable_on, :integer
    field :replayable_on, :integer

  end

  def changeset(id, params \\ %{}) do
    id
    |> Ecto.Changeset.cast(params, [:op, :issuer, :receiver, :created_on, :written_on, :sig, :expires_on, :expired_on, :chainable_on, :replayable_on])
    |> Ecto.Changeset.validate_required([:op, :issuer, :receiver, :created_on, :written_on, :sig, :expires_on, :chainable_on, :replayable_on])
    |> Ecto.Changeset.unique_constraint(:issuer)
  end
end

