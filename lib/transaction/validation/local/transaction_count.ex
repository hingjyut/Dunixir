defmodule Block.Validation.Local.TransactionCount do
  def valid(block) do
    Enum.all?(block["transactions"], fn element ->
      length(element["signatures"]) == length(element["issuers"])
    end)
  end
end
