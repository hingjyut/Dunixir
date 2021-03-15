defmodule ToLeaverTest do
  use  ExUnit.Case
  doctest Index.Augmentation.CIndex

  setup_all do

    local_cindex = :ets.new(:"test/local_cindex", [:set, :protected])
    local_mindex = :ets.new(:"test/local_mindex", [:set, :protected])

    :ets.insert(local_cindex, {0, %{receiver: "XYZ_pkey"}})
    :ets.insert(local_mindex, {0, %{leaving: nil, pub: "XYZ_pkey"}})
    :ets.insert(local_mindex, {1, %{leaving: true, pub: "XYZ_pkey"}})
    :ets.insert(local_mindex, {2, %{leaving: false, pub: "XYA_pkey"}})
    :ets.insert(local_mindex, {3, %{leaving: nil, pub: "XYZ_pkey"}})
    Index.Augmentation.CIndex.toLeaver(local_cindex, local_mindex,0)
    [{0, entry}] = :ets.lookup(local_cindex, 0)
    toLeaverTrue = entry.toLeaver

    :file.delete("test/local_cindex")
    :file.delete("test/local_mindex")

    local_cindex = :ets.new(:"test/local_cindex", [:set, :protected])
    local_mindex = :ets.new(:"test/local_mindex", [:set, :protected])

    :ets.insert(local_cindex, {0, %{receiver: "XYZ_pkey"}})
    :ets.insert(local_mindex, {0, %{leaving: nil, pub: "XYZ_pkey"}})
    :ets.insert(local_mindex, {1, %{leaving: false, pub: "XYZ_pkey"}})
    Index.Augmentation.CIndex.toLeaver(local_cindex, local_mindex,0)
    [{0, entry}] = :ets.lookup(local_cindex, 0)
    toLeaverFalse = entry.toLeaver

    :file.delete("test/local_cindex")
    :file.delete("test/local_mindex")

    {:ok, toLeaverTrue: toLeaverTrue, toLeaverFalse: toLeaverFalse}
  end

  test "check toLeaver", state do
    assert state.toLeaverTrue == true
    assert state.toLeaverFalse == false
  end
end
