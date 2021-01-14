defmodule Block.Validation.Local.TransactionVersion do
  def valid(block) do
    Enum.all?(block["transactions"], fn element -> element["version"] == 10 end)
  end
end