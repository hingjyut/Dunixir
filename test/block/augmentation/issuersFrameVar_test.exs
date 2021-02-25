defmodule Block.Augmentation.IssuersFrameVarTest do
  use ExUnit.Case

  doctest Index.Augmentation.BIndex

  setup_all do
    :file.delete("test/global_bindex")
    local_bindex = :ets.new(:"test/local_bindex", [:ordered_set, :protected])
    {:ok, global_bindex} = :dets.open_file(:"test/global_bindex", type: :set)
    :dets.insert(global_bindex, {2, %{number: 2, issuersFrameVar: 5, issuersCount: 19}})
    :dets.insert(global_bindex, {1, %{number: 1, issuersFrameVar: -3, issuersCount: 51 }})
    :dets.insert(global_bindex, {0, %{number: 0, issuersFrameVar: 0, issuersCount: 24 }})

    :ets.insert(local_bindex, {4, %{number: 0, issuersCount: 58}})
    Index.Augmentation.BIndex.issuersFrameVar(global_bindex, local_bindex)
    [{4, head}] = :ets.lookup(local_bindex, 4)
    issuersFrameVar_0 = head.issuersFrameVar

    :ets.insert(local_bindex, {3, %{number: 3,issuersCount: 29}})
    Index.Augmentation.BIndex.issuersFrameVar(global_bindex, local_bindex)
    [{3, head}] = :ets.lookup(local_bindex, 3)
    issuersFrameVar_54 = head.issuersFrameVar

    :ets.insert(local_bindex, {2, %{number: 2,issuersCount: 17}})
    Index.Augmentation.BIndex.issuersFrameVar(global_bindex, local_bindex)
    [{2, head}] = :ets.lookup(local_bindex, 2)
    issuersFrameVar_m172 = head.issuersFrameVar

    :ets.insert(local_bindex, {1, %{number: 1,issuersCount: 38}})
    Index.Augmentation.BIndex.issuersFrameVar(global_bindex, local_bindex)
    [{1, head}] = :ets.lookup(local_bindex, 1)
    issuersFrameVar_70 = head.issuersFrameVar

    :dets.close(global_bindex)
    :dets.close(local_bindex)
    :file.delete("test/global_bindex")
    :file.delete("test/local_bindex")

    {:ok, issuersFrameVar_0: issuersFrameVar_0, issuersFrameVar_54: issuersFrameVar_54, issuersFrameVar_m172: issuersFrameVar_m172, issuersFrameVar_70: issuersFrameVar_70}
  end

  test "check previousIssuer", state do
    assert state.issuersFrameVar_0 == 0
    assert state.issuersFrameVar_54== 54
    assert state.issuersFrameVar_m172 == -172
    assert state.issuersFrameVar_70 == 70
  end
end
