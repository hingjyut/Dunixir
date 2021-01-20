defmodule Block.Augmentation.PreviousHash do
  use ExUnit.Case

  doctest Index.Augmentation.BIndex

  setup_all  do

    local_bindex = :ets.new(:local_bindex,[:set,:protected])
    :ets.insert(local_bindex, {0, %{number: 0}})

    :file.delete("test/global_bindex")
    {:ok, global_bindex} = :dets.open_file(:"test/global_bindex", [type: :set])

    Index.Augmentation.BIndex.previousHash(global_bindex, local_bindex)
    [{0, head}] = :ets.lookup(local_bindex, 0)
    previousHash0 = head.previousHash

    :ets.insert(local_bindex, {0, %{number: 1}})
    :dets.insert(global_bindex, {0, %{number: 0, hash: "hashTest"}})

    Index.Augmentation.BIndex.previousHash(global_bindex, local_bindex)
    [{0, head}] = :ets.lookup(local_bindex, 0)
    previousHash1 = head.previousHash

    {:ok, previousHash0: previousHash0, previousHash1: previousHash1}

  end

  test "check previousHash",state do
    assert is_nil(state.previousHash0)
    assert state.previousHash1 == "hashTest"
  end

end
