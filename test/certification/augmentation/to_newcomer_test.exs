defmodule ToNewcomerTest do
  use  ExUnit.Case
  doctest Index.Augmentation.CIndex

  setup_all do

    local_cindex = :ets.new(:"test/local_cindex", [:set, :protected])
    local_good_iindex = :ets.new(:"test/local_good_iindex", [:set, :protected])
    local_bad_iindex = :ets.new(:"test/local_bad_iindex", [:set, :protected])

    :ets.insert(local_cindex, {0, %{receiver: "XYZ_pkey"}})
    :ets.insert(local_good_iindex, {0, %{member: true, pub: "XYZ_pkey"}})
    :ets.insert(local_good_iindex, {1, %{member: true, pub: "XYZ_pkey"}})
    :ets.insert(local_good_iindex, {2, %{member: true, pub: "XYZ_pkey"}})
    :ets.insert(local_good_iindex, {3, %{member: false, pub: "XYZ_pkey"}})
    :ets.insert(local_good_iindex, {4, %{member: true, pub: "ABC_pkey"}})
    :ets.insert(local_good_iindex, {5, %{member: false, pub: "ABC_pkey"}})
    Index.Augmentation.CIndex.toNewcomer(local_cindex, local_good_iindex,0)
    [{0, entry}] = :ets.lookup(local_cindex, 0)
    toNewcomer_good = entry.toNewcomer

    :ets.insert(local_cindex, {0, %{receiver: "XYZ_pkey"}})
    :ets.insert(local_bad_iindex, {3, %{member: false, pub: "XYZ_pkey"}})
    :ets.insert(local_bad_iindex, {4, %{member: true, pub: "ABC_pkey"}})
    :ets.insert(local_bad_iindex, {5, %{member: false, pub: "ABC_pkey"}})
    Index.Augmentation.CIndex.toNewcomer(local_cindex, local_bad_iindex,0)
    [{0, entry}] = :ets.lookup(local_cindex, 0)
    toNewcomer_bad = entry.toNewcomer

    :dets.close(local_cindex)
    :dets.close(local_good_iindex)
    :dets.close(local_bad_iindex)
    :file.delete("test/local_cindex")
    :file.delete("test/local_good_iindex")
    :file.delete("test/local_bad_iindex")

    {:ok, toNewcomer_good: toNewcomer_good, toNewcomer_bad: toNewcomer_bad}
  end

  test "check toNewcomer", state do
    assert state.toNewcomer_good == true
    assert state.toNewcomer_bad == false
  end
end
