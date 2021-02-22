defmodule Block.Validation.Local.UniversalDividend do
  
  def valid(block) do
    block["number"]===0 and block["dividend"]===nil
  end

end
