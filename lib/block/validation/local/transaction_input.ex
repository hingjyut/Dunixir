defmodule Block.Validation.Local.TransactionInput do
  def valid(block) do
    case block["transactions"] do
      [] ->
        true

      transac ->
        Enum.all?(transac, fn tx ->
          case tx["inputs"] do
            [] -> false
            input -> Enum.any?(input, fn el -> String.length(el) != 0 end)
          end
        end)
    end
  end
end
