defmodule BMA.Wot.RequirementsOfPending do
  def get(minsig) do
    Poison.encode!("#TODO " <> minsig)
  end
end
