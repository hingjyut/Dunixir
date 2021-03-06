defmodule Identity.Augmentation.PubUnique do
  use ExUnit.Case

  doctest Index.Augmentation.IIndex

  setup_all  do
    local_iindex_a = :ets.new(:local_iindex,[:set,:protected])
    local_iindex_b = :ets.new(:local_iindex,[:set,:protected])
    local_mindex_a = :ets.new(:local_mindex,[:set,:protected])
    local_mindex_b = :ets.new(:local_mindex,[:set,:protected])
    Index.Generation.add_identity("blockstamp_test", local_iindex_a,local_mindex_a,%{"pub" => "pub_toto",
    "block_uid" => "block_uid_test",
    "user_id"=> "user_id_test"})
    Index.Generation.add_identity("blockstamp_test", local_iindex_b,local_mindex_b,%{"pub" => "pub_toto",
    "block_uid" => "block_uid_test",
    "user_id"=> "user_id_test"})
    {:ok, global_iindex_a} = :dets.open_file(:global_iindex_a, [type: :set])
    {:ok, global_iindex_b} = :dets.open_file(:global_iindex_b, [type: :set])
    :ets.to_dets(local_iindex_a,:global_iindex_a)
    :ets.to_dets(local_iindex_b,:global_iindex_b)

    [{"pub_toto",elt}] = :dets.lookup(:global_iindex_b,"pub_toto")
    new_elt = Map.replace!(elt,:pub,"pub_tata")
    :dets.insert(:global_iindex_b, {"pub_toto",new_elt})

    Index.Augmentation.IIndex.pubUnique(local_iindex_a,global_iindex_a,"pub_toto")
    Index.Augmentation.IIndex.pubUnique(local_iindex_b,global_iindex_b,"pub_toto")
    [{"pub_toto",a}] = :ets.lookup(local_iindex_a,"pub_toto")
    [{"pub_toto",b}] = :ets.lookup(local_iindex_b,"pub_toto")

    {:ok,pub_unique_a: a.pubUnique, pub_unique_b: b.pubUnique}
  end

  test "check pubUnique is the right value",state do
    assert state.pub_unique_b
    refute state.pub_unique_a

  end


end
