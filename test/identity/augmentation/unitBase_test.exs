defmodule Identity.Augmentation.UnitBase do
  use ExUnit.Case

  doctest Index.Augmentation.SIndex

  @block_BINDEX %{
    "version" => 10,
    "size" => 786,
    "hash" => "0001CC094C5A8717521506DF6002945E7F4350B6DBA9BFC782E8AC68E697CDA0",
    "issuer" => "5B8iMAzq1dNmFe3ZxFTBQkqhq4fsztg1gZvxHXCk1XYH",
    "time" => 1546252844,
    "number" => 2000,
    "currency" => nil,
    "previousHash" => nil,
    "previousIssuer" => nil,
    "unitBase" => 1,
    "powMin" => 10,
    "udTime" => nil,
    "diffTime" => nil,
    "speed" => nil,

  }



  setup_all  do
    # Create global bindex
    {:ok, global_bindex} = :dets.open_file(:global_bindex, [type: :set])
    :dets.insert(:global_bindex, {@block_BINDEX["number"],@block_BINDEX})
    # the number of last block(HEAD) is 20
    :dets.insert(:global_bindex, {:last_block, 20})


    local_sindex = :ets.new(:local_sindex,[:set,:protected])

    # Insert one block with valid unitBase of 0 into local sindex
    Index.Generation.add_tx_output("blockstamp_test", local_sindex, %{"tx_hash" => "tx_hash_test_a",
    "output_index" => "output_index_test",
    "output_amount" => 90,
    "output_base" => 0,
    "locktime" => "locktime_test",
    "conditions" => "conditions_test"})
    key_a = {"CREATE", "tx_hash_test_a", "output_index_test"}


    # Insert one block with invalid unitBase of 99 into local sindex
    Index.Generation.add_tx_output("blockstamp_test", local_sindex, %{"tx_hash" => "tx_hash_test_b",
    "output_index" => "output_index_test",
    "output_amount" => 90,
    "output_base" => 99,
    "locktime" => "locktime_test",
    "conditions" => "conditions_test"})
    key_b = {"CREATE", "tx_hash_test_b", "output_index_test"}

    {:ok, local_sindex: local_sindex, global_bindex: global_bindex, key_a: key_a, key_b: key_b}
  end

  alias Index.Augmentation.SIndex, as: SIndex

  test "check unitBase is the right value", state do
    assert SIndex.checkUnitBase(state[:local_sindex], state[:global_bindex], state[:key_a])
    refute SIndex.checkUnitBase(state[:local_sindex], state[:global_bindex], state[:key_b])
  end


end
