defmodule Block.Augmentation.IssuersCountTest do
  use ExUnit.Case

  doctest Index.Augmentation.BIndex

  setup_all do
    local_bindex = :ets.new(:local_bindex, [:set, :protected])

    :file.delete("test/global_bindex")
    {:ok, global_bindex} = :dets.open_file(:"test/global_bindex", type: :set)
    :dets.insert(global_bindex, {0, %{number: 0, issuersFrame: 1, issuer: "a"}})
    :dets.insert(global_bindex, {1, %{number: 1, issuersFrame: 2, issuer: "b"}})
    :dets.insert(global_bindex, {2, %{number: 2, issuersFrame: 3, issuer: "a"}})

    :ets.insert(local_bindex, {4, %{number: 0}})
    Index.Augmentation.BIndex.issuersCount(global_bindex, local_bindex)
    [{4, head}] = :ets.lookup(local_bindex, 4)
    issuersCount0 = head.issuersCount

    :ets.insert(local_bindex, {4, %{number: 1}})
    Index.Augmentation.BIndex.issuersCount(global_bindex, local_bindex)
    [{4, head}] = :ets.lookup(local_bindex, 4)
    issuersCount1 = head.issuersCount

    :ets.insert(local_bindex, {4, %{number: 2}})
    Index.Augmentation.BIndex.issuersCount(global_bindex, local_bindex)
    [{4, head}] = :ets.lookup(local_bindex, 4)
    issuersCount2 = head.issuersCount

    :ets.insert(local_bindex, {4, %{number: 3}})
    Index.Augmentation.BIndex.issuersCount(global_bindex, local_bindex)
    [{4, head}] = :ets.lookup(local_bindex, 4)

    issuersCount3 = head.issuersCount

    :dets.close(global_bindex)
    :file.delete("test/global_bindex")


    {:ok,
    issuersCount0: issuersCount0,
    issuersCount1: issuersCount1 ,
     issuersCount2: issuersCount2 ,
     issuersCount3: issuersCount3}
  end

  test "check issuersCount", state do
    assert state.issuersCount0 == 0
    assert state.issuersCount1 == 1
    assert state.issuersCount2 == 2
    assert state.issuersCount3 == 2
  end
end
