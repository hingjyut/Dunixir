defmodule Certification do
  use Ecto.Schema

  schema "certifications" do
    field :uid, :string
    field :pubkey, :string
    field :from_pubkey, :string
    field :written, :boolean
  end
end
