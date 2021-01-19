defmodule Identity.Augmentation.ExcludedIsMember do
  use ExUnit.Case

  doctest Index.Augmentation.IIndex

  setup_all  do
    local_iindex_a = :ets.new(:local_iindex,[:set,:protected])
    local_iindex_b = :ets.new(:local_iindex,[:set,:protected])
    local_mindex_a = :ets.new(:local_mindex,[:set,:protected])
    local_mindex_b = :ets.new(:local_mindex,[:set,:protected])

    :lists.foreach(fn {iindex,mindex} ->
      Index.Generation.add_identity("blockstamp_test", iindex,mindex,%{"pub" => "pub_toto",
    "block_uid" => "block_uid_test",
    "user_id"=> "user_id_test"})
      Index.Generation.add_excluded("blockstamp_test",iindex,%{"pub" => "pub_tata"})
    end, [{local_iindex_a,local_mindex_a},{local_iindex_b,local_mindex_b}])


    {:ok, global_iindex_a} = :dets.open_file(:global_iindex_a, [type: :set])
    {:ok, global_iindex_b} = :dets.open_file(:global_iindex_b, [type: :set])
    :ets.to_dets(local_iindex_a,:global_iindex_a)
    :ets.to_dets(local_iindex_b,:global_iindex_b)
    :dets.delete(:global_iindex_b, "pub_tata")

    :lists.foreach(fn index -> [{"pub_toto",elt}] = :dets.lookup(index,"pub_toto")
    new_elt = Map.replace!(elt,:pub,"pub_tata")
    :dets.insert(index, {"pub_toto",new_elt})
  end, [:global_iindex_a, :global_iindex_b] )

    Index.Augmentation.IIndex.excludedIsMember(local_iindex_a,global_iindex_a,"pub_toto")
    Index.Augmentation.IIndex.excludedIsMember(local_iindex_a,global_iindex_a,"pub_tata")
    Index.Augmentation.IIndex.excludedIsMember(local_iindex_b,global_iindex_b,"pub_toto")
    Index.Augmentation.IIndex.excludedIsMember(local_iindex_b,global_iindex_b,"pub_tata")

    [{"pub_toto",a_id}] = :ets.lookup(local_iindex_a,"pub_toto")
    [{"pub_toto",b_id}] = :ets.lookup(local_iindex_b,"pub_toto")
    [{"pub_tata",a_excl}] = :ets.lookup(local_iindex_a,"pub_tata")
    [{"pub_tata",b_excl}] = :ets.lookup(local_iindex_b,"pub_tata")

    :dets.close(global_iindex_a)
    :dets.close(global_iindex_b)
    :file.delete("global_iindex_a")
    :file.delete("global_iindex_b")

    {:ok,id_a: a_id.excludedIsMember,excl_a: a_excl.excludedIsMember, id_b: b_id.excludedIsMember, excl_b: b_excl.excludedIsMember}
  end

  test "check pubUnique is the right value",state do
    assert state.id_a
    refute state.excl_a
    assert state.id_b
    assert state.excl_b
  end


end
