defmodule LocalIIndex do
  use Ecto.Schema

  schema "local_i_index" do
    field :op, :string
    field :uid, :string
    field :pub, :string
    field :hash, :string
    field :sig, :string
    field :created_on, :string
    field :written_on, :string
    field :member, :boolean
    field :was_member, :boolean
    field :kick, :boolean
  end
  
  def changeset(id, params \\ %{}) do
    id
    |> Ecto.Changeset.cast(params, [:op, :uid, :pub, :hash, :sig, :created_on, :written_on, :member, :was_member, :kick])
    |> Ecto.Changeset.validate_required([:op, :pub, :written_on])
    |> Ecto.Changeset.unique_constraint(:uid)
    |> Ecto.Changeset.unique_constraint(:pub)
  end
end
