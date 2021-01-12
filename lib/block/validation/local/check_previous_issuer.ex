defmodule Block.Validation.Local.PreIssuer do
  def valid(block) do
    not (block["number"] == 0 and block["previousIssuer"] != nil) 
    and 
    not (block["number"] > 0 and block["previousIssuer"] == nil)
  end
end
