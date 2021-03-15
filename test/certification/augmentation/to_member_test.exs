defmodule ToMemberTest do
  use  ExUnit.Case
  doctest Index.Augmentation.CIndex

  setup_all do

    :file.delete("test/global_iindex")
    local_cindex = :ets.new(:"test/local_cindex", [:set, :protected])
    {:ok, global_iindex} = :dets.open_file(:"test/global_iindex", type: :set)

    :ets.insert(local_cindex, {0, %{issuer: "XYZ_pkey"}})
    :dets.insert(global_iindex, {0, %{member: nil, pub: "XYZ_pkey"}})
    :dets.insert(global_iindex, {1, %{member: true, pub: "XYZ_pkey"}})
    :dets.insert(global_iindex, {2, %{member: false, pub: "XYA_pkey"}})
    :dets.insert(global_iindex, {3, %{member: nil, pub: "XYZ_pkey"}})
    Index.Augmentation.CIndex.toMember(local_cindex, global_iindex,0)
    [{0, entry}] = :ets.lookup(local_cindex, 0)
    toMemberTrue = entry.toMember

    :dets.close(global_iindex)
    :file.delete("test/local_cindex")
    :file.delete("test/global_iindex")

    local_cindex = :ets.new(:"test/local_cindex", [:set, :protected])
    {:ok, global_iindex} = :dets.open_file(:"test/global_iindex", type: :set)

    :ets.insert(local_cindex, {0, %{issuer: "XYZ_pkey"}})
    :dets.insert(global_iindex, {0, %{member: nil, pub: "XYZ_pkey"}})
    :dets.insert(global_iindex, {1, %{member: false, pub: "XYZ_pkey"}})
    Index.Augmentation.CIndex.toMember(local_cindex, global_iindex,0)
    [{0, entry}] = :ets.lookup(local_cindex, 0)
    toMemberFalse = entry.toMember

    :dets.close(global_iindex)
    :file.delete("test/local_cindex")
    :file.delete("test/global_iindex")

    {:ok, toMemberTrue: toMemberTrue, toMemberFalse: toMemberFalse}
  end

  test "check toMember", state do
    assert state.toMemberTrue == true
    assert state.toMemberFalse == false
  end
end
