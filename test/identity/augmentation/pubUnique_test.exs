defmodule Identity.Augmentation.PubUnique do
  use ExUnit.Case

  doctest Index.Augmentation.IIndex

  setup_all  do
    local_iindex = :ets.new(:local_iindex,[:set,:protected])
    local_mindex = :ets.new(:local_mindex,[:set,:protected])
    Index.Generation.add_identity("blockstamp_test", local_iindex,local_mindex,%{"pub" => "pub_toto",
    "block_uid" => "block_uid_test",
    "user_id"=> "user_id_toto"})
    Index.Generation.add_identity("blockstamp_test", local_iindex,local_mindex,%{"pub" => "pub_tata",
    "block_uid" => "block_uid_test",
    "user_id"=> "user_id_tata"})
    {:ok, global_iindex} = :dets.open_file(:"test/global_iindex", [type: :set])
    :ets.to_dets(local_iindex,global_iindex)

    [{"pub_toto",elt}] = :dets.lookup(global_iindex,"pub_toto")
    :dets.delete(global_iindex,"pub_toto")
    new_elt = Map.replace!(elt,:pub,"pub_tutu")
    :dets.insert(global_iindex, {"pub_tutu",new_elt})

    Index.Augmentation.IIndex.pubUnique(local_iindex,global_iindex,"pub_toto")
    Index.Augmentation.IIndex.pubUnique(local_iindex,global_iindex,"pub_tata")
    [{"pub_toto",toto}] = :ets.lookup(local_iindex,"pub_toto")
    [{"pub_tata",tata}] = :ets.lookup(local_iindex,"pub_tata")

    :dets.close(global_iindex)
    :file.delete("test/global_iindex")

    {:ok,pub_unique_toto: toto.pubUnique, pub_unique_tata: tata.pubUnique}
  end

  test "check pubUnique is the right value",state do
    assert state.pub_unique_toto
    refute state.pub_unique_tata

  end


end
