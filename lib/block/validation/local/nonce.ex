defmodule Block.Validation.Local.Nonce do
  def valid(block) do
    block["nonce"] >= 0
  end
end
