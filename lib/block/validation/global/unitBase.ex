defmodule Block.Augmentation.UnitBase do

  def getUnitBase(local_bindex, global_bindex) do
    [{:last_block, last_block}] = :dets.lookup(global_bindex, :last_block)
    if last_block == 0 do
      :ets.insert(local_bindex, {"unitBase", 0})
    else
      [[unitBase]] = :dets.match(global_bindex,{:_,%{number: last_block, unitBase: "$1"}})
      :ets.insert(local_bindex, {"unitBase", unitBase})
    end
  end

end
