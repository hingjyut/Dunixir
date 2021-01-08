defmodule Block.Validation.Local.Version do
  def valid(block) do
    block["version"] >= 10
  end
end
