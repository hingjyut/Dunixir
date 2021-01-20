defmodule Block.Augmentation.PreviousIssuer.Test do
  use ExUnit.Case
  doctest Block.Augmentation.PreviousIssuer
  alias Block.Augmentation.PreviousIssuer as: PrevIssuer

  setup_all  do

    local_bindex = :ets.new(:local_bindex,[:set,:protected])
    :ets.insert(local_bindex, {0, %{number: 0}})

    :file.delete("test/global_bindex")
    {:ok, global_bindex} = :dets.open_file(:"test/global_bindex", [type: :set])

    PrevIssuer.getPreviousIssuer(global_bindex, local_bindex)
    [{0, head}] = :ets.lookup(local_bindex, 0)
    previousIssuer0 = head.previousIssuer

    :ets.insert(local_bindex, {0, %{number: 1}})
    :dets.insert(global_bindex, {0, %{number: 0, issuer: "issuerTest"}})

    PrevIssuer.previousIssuer(global_bindex, local_bindex)
    [{0, head}] = :ets.lookup(local_bindex, 0)
    previousIssuer1 = head.previousIssuer1

    :dets.close(global_bindex)
    :file.delete("test/global_bindex")

    {:ok, previousIssuer0: previousIssuer0, previousIssuer1: previousIssuer1}

  end

  test "check previousIssuer",state do
    assert is_nil(state.previousIssuer0)
    assert state.previousIssuer1 == "issuerTest"
    assert false
  end


end
