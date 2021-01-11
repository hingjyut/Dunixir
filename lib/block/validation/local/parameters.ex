defmodule Block.Validation.Local.Parameters do
  def valid(block) do
    ((block["number"] == 0 and block["parameters"] != "") or (block["number"] >0 and block["parameters"] == "" ))
  end
end
