defmodule Identity do
  use Ecto.Schema

  schema "identities" do
    field :uid, :string
    field :pubkey, :string
    field :member, :boolean
  end

  def changeset(id, params \\ %{}) do
    id
    |> Ecto.Changeset.cast(params, [:uid, :pubkey, :member])
    |> Ecto.Changeset.validate_required([:pubkey])
    |> Ecto.Changeset.unique_constraint(:pubkey)
    |> Ecto.Changeset.unique_constraint(:uid)
  end
end
