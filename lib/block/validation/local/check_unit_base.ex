defmodule Block.Validation.Local.UnitBase do
  def valid(block) do
    not (block['unitbase'] != 0 && block['number'] == 0)
  end
end
