defmodule LocalSIndex do
  use Ecto.Schema

  schema "local_s_index" do
    field :op, :string
    field :tx, :string
    field :identifier, :string
    field :pos, :integer
    field :created_on, :string
    field :amount, :integer
    field :base, :integer
    field :locktime, :integer
    field :consumed, :boolean
    field :conditions, :string
    field :written_on, :integer
  end

  def changeset(id, params \\ %{}) do
    id
    |> Ecto.Changeset.cast(params, [:op, :tx, :identifier, :pos, :created_on, :amount, :base, :locktime, :consumed, :conditions, :written_on])
    |> Ecto.Changeset.validate_required([:op, :identifier, :pos, :amount, :base, :locktime, :consumed, :conditions, :written_on])
    |> Ecto.Changeset.unique_constraint([:op,:identifier,:pos])
  end
end




