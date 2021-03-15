defmodule Block.Validation.Local.TransactionNumberOfLines do
  def valid(block) do
    length(block["transactions"]) < 100
  end
end
