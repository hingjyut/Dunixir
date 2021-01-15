defmodule Block.Validation.Local.PreviousHash do
  def valid(block) do
    cond do
      block["number"] > 0 ->
        String.length(block["previousHash"]) > 0
      block["number"] == 0 ->
        String.length(block["previousHash"]) == 0
    end
  end
end