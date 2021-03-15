defmodule Block.Augmentation.IssuersFrameTest do
  use ExUnit.Case

  doctest Index.Augmentation.BIndex

  setup_all do
    local_bindex = :ets.new(:local_bindex, [:set, :protected])

    :file.delete("test/global_bindex")
    {:ok, global_bindex} = :dets.open_file(:"test/global_bindex", type: :set)
    :dets.insert(global_bindex, {2, %{number: 2, issuersFrameVar: 0, issuersFrame: 5}})
    :dets.insert(global_bindex, {1, %{number: 1, issuersFrameVar: -1, issuersFrame: 5}})
    :dets.insert(global_bindex, {0, %{number: 0, issuersFrameVar: 1, issuersFrame: 5}})

    :ets.insert(local_bindex, {4, %{number: 0}})
    Index.Augmentation.BIndex.issuersFrame(global_bindex, local_bindex)
    [{4, head}] = :ets.lookup(local_bindex, 4)
    issuersFrame0 = head.issuersFrame

    :ets.insert(local_bindex, {4, %{number: 1}})
    Index.Augmentation.BIndex.issuersFrame(global_bindex, local_bindex)
    [{4, head}] = :ets.lookup(local_bindex, 4)
    issuersFrame1 = head.issuersFrame

    :ets.insert(local_bindex, {4, %{number: 2}})
    Index.Augmentation.BIndex.issuersFrame(global_bindex, local_bindex)
    [{4, head}] = :ets.lookup(local_bindex, 4)

    issuersFrame2 = head.issuersFrame

    :ets.insert(local_bindex, {4, %{number: 3}})
    Index.Augmentation.BIndex.issuersFrame(global_bindex, local_bindex)
    [{4, head}] = :ets.lookup(local_bindex, 4)

    issuersFrame3 = head.issuersFrame

    :dets.close(global_bindex)
    :file.delete("test/global_bindex")

    {:ok,
     issuersFrame0: issuersFrame0,
     issuersFrame1: issuersFrame1,
     issuersFrame2: issuersFrame2,
     issuersFrame3: issuersFrame3}
  end

  test "check issuersFrame", state do
    assert state.issuersFrame0 == 1
    assert state.issuersFrame1 == 6
    assert state.issuersFrame2 == 4
    assert state.issuersFrame3 == 5
  end
end
