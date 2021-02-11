defmodule Identity.Augmentation.IsBeingRevoked do
  use ExUnit.Case

  doctest Index.Augmentation.MIndex

  setup_all  do
    :file.delete("test/local_mindex")
    local_mindex = :ets.new(:"test/local_mindex",[:set,:protected])

    :ets.insert(local_mindex, {1, %{revoked_on: "02/11/2021:12:46:57/GMT-1"}})
    Index.Augmentation.MIndex.isBeingRevoked(local_mindex,1)
    [{1, entry}] = :ets.lookup(local_mindex, 1)
    isrevoked = entry.isBeingRevoked

    :ets.insert(local_mindex, {0, %{revoked_on: nil}})
    Index.Augmentation.MIndex.isBeingRevoked(local_mindex,0)
    [{0, entry}] = :ets.lookup(local_mindex, 0)
    isnoterevoked = entry.isBeingRevoked

    :dets.close(local_mindex)
    :file.delete("test/local_mindex")

    {:ok, isrevoked: isrevoked, isnoterevoked: isnoterevoked}

  end

  test "check isBeingRevoked",state do
    assert state.isrevoked == true
    assert state.isnoterevoked == false
  end

end
