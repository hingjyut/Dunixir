defmodule Block.Validation.Local.TransacVersion do
  def valid(block) do
    block["transactions"]["version"] >= 10
  end
end
