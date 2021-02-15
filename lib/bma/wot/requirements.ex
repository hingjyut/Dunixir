defmodule BMA.Wot.Requirements do
  def get(search) do
    Poison.encode!("#TODO " <> search)
  end
end
