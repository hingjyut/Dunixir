defmodule Block.Augmentation.UdTimeTest do
  use ExUnit.Case

  doctest Index.Augmentation.BIndex

  setup_all do
    local_bindex = :ets.new(:local_bindex, [:set, :protected])

    :file.delete("test/global_bindex")
    {:ok, global_bindex} = :dets.open_file(:"test/global_bindex", type: :set)

    # :dets.insert(global_bindex, {2, %{number: 2, udTime: 4, udReevalTime: 3}})
    :dets.insert(global_bindex, {1, %{number: 1, udTime: 10, udReevalTime: 15}})
    :dets.insert(global_bindex, {0, %{number: 0, udTime: 3, udReevalTime: 1}})

    :ets.insert(local_bindex, {4, %{number: 0}})
    Index.Augmentation.BIndex.udTime(global_bindex, local_bindex)
    [{4, head}] = :ets.lookup(local_bindex, 4)
    udTimeNumber0 = head.udTime
    udReevalTime0 = head.udReevalTime

    :ets.insert(local_bindex, {4, %{number: 1, medianTime: 4}})
    Index.Augmentation.BIndex.udTime(global_bindex, local_bindex)
    [{4, head}] = :ets.lookup(local_bindex, 4)
    udTime1 = head.udTime
    udReevalTime1 = head.udReevalTime

    :ets.insert(local_bindex, {4, %{number: 2, medianTime: 3}})
    Index.Augmentation.BIndex.udTime(global_bindex, local_bindex)
    [{4, head}] = :ets.lookup(local_bindex, 4)

    udTime2 = head.udTime
    udReevalTime2 = head.udReevalTime

    :dets.close(global_bindex)
    :file.delete("test/global_bindex")

    {:ok,
     udTimeNumber0: udTimeNumber0,
     udTime1: udTime1,
     udTime2: udTime2,
     udReevalTime0: udReevalTime0,
     udReevalTime1: udReevalTime1,
     udReevalTime2: udReevalTime2}
  end

  test "check udTime", state do
    assert state.udTimeNumber0 == ConfDTO.mockConfDTO().udTime0
    assert state.udTime1 == 3 + ConfDTO.mockConfDTO().dt
    assert state.udTime2 == 10
  end

  test "check udReevalTime", state do
    assert state.udReevalTime0 == ConfDTO.mockConfDTO().udReevalTime0
    assert state.udReevalTime1 == 1 + ConfDTO.mockConfDTO().dtReeval
    assert state.udReevalTime2 == 15
  end
end
