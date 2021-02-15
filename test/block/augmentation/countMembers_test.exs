defmodule Identity.Augmentation.MembersCount do
  use ExUnit.Case

  doctest Index.Augmentation.IIndex

  setup_all do
    local_iindex = :ets.new(:local_iindex, [:set, :protected])
    local_mindex = :ets.new(:local_mindex, [:set, :protected])
    local_bindex = :ets.new(:local_bindex, [:set, :protected])

    Enum.each(0..4, fn x ->
      Index.Generation.add_identity("blockstamp_test", local_iindex, local_mindex, %{
        "pub" => "pub_#{x}",
        "block_uid" => "block_uid_#{x}",
        "user_id" => "user_id_#{x}"
      })
    end)

    Enum.each(0..2, fn x ->
      Index.Generation.add_excluded("blockstamp_test", local_iindex, %{"pub" => "pub_#{x + 5}"})
    end)

    :ets.insert(local_bindex, {1, %{number: 1}})

    {:ok, global_bindex} = :dets.open_file(:"test/global_bindex", type: :set)
    :dets.insert(global_bindex, {0, %{number: 0, membersCount: 3}})

    Index.Augmentation.BIndex.membersCount(local_iindex, global_bindex, local_bindex)

    key = :ets.first(local_bindex)
    [{_key, head}] = :ets.lookup(local_bindex, key)

    :dets.close(global_bindex)
    :file.delete("test/global_bindex")
    {:ok, membersCount: head.membersCount}
  end

  test "check membersCount", state do
    assert state.membersCount == 5
  end
end
