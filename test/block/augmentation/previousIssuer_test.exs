defmodule Block.Augmentation.PreviousIssuer do
  use ExUnit.Case

  doctest Index.Augmentation.BIndex

  setup_all  do
    :file.delete("test/local_bindex")
    :file.delete("test/global_bindex")
    local_bindex = :ets.new(:"test/local_bindex",[:set,:protected])
    {:ok, global_bindex} = :dets.open_file(:"test/global_bindex", [type: :set])

    :ets.insert(local_bindex, {1, %{number: -1}})
    Index.Augmentation.BIndex.previousIssuer(global_bindex, local_bindex)
    [{1, head}] = :ets.lookup(local_bindex, 1)
    previousIssuer_nil = head.previousIssuer

    :ets.insert(local_bindex, {0, %{number: 2}})
    :dets.insert(global_bindex, {0, %{number: 1, issuer: "John Smith"}})
    Index.Augmentation.BIndex.previousIssuer(global_bindex, local_bindex)
    [{0, head}] = :ets.lookup(local_bindex, 0)
    previousIssuer_actual = head.previousIssuer

    :dets.close(global_bindex)
    :dets.close(local_bindex)
    :file.delete("test/global_bindex")
    :file.delete("test/local_bindex")

    {:ok, previousIssuer_nok: previousIssuer_nil, previousIssuer_ok: previousIssuer_actual}

  end

  test "check previousIssuer",state do
    assert state.previousIssuer_nok == nil
    assert state.previousIssuer_ok == "John Smith"
  end

end
