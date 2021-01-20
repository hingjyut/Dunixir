defmodule Block.Augmentation.PreviousIssuer do

  def getPreviousIssuer(local_bindex, global_bindex) do
    IO.puts("Reached")
    [{:last_block, last_block}] = :dets.lookup(global_bindex, :last_block)
    if last_block == 0 do
      :ets.insert(local_bindex, {"previousIssuer", nil})
    else
      [[previousIssuer]] = :dets.match(global_bindex,{:_,%{number: last_block, issuer: "$1"}})
      :ets.insert(local_bindex, {"previousIssuer", previousIssuer})
    end
  end

end
