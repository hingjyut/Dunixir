defmodule Identity.ToProcess do
  use Ecto.Schema

  schema "sandbox_idty" do
    field :uid, :string
    field :pubkey, :string
    field :member, :boolean
  end
end
