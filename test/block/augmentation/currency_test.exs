defmodule Block.Augmentation.Currency do
  use ExUnit.Case

  doctest Index.Augmentation.BIndex

  setup_all do
    local_bindex = :ets.new(:local_bindex, [:set, :protected])
    :ets.insert(local_bindex, {0, %{number: 0}})

    :file.delete("test/global_bindex")
    {:ok, global_bindex} = :dets.open_file(:"test/global_bindex", type: :set)

    Index.Augmentation.BIndex.currency(global_bindex, local_bindex)
    [{0, head}] = :ets.lookup(local_bindex, 0)
    currency0 = head.currency

    :ets.insert(local_bindex, {0, %{number: 1}})
    :dets.insert(global_bindex, {0, %{number: 0, currency: "currencyTest"}})

    Index.Augmentation.BIndex.currency(global_bindex, local_bindex)
    [{0, head}] = :ets.lookup(local_bindex, 0)
    currency1 = head.currency

    :dets.close(global_bindex)
    :file.delete("test/global_bindex")

    {:ok, currency0: currency0, currency1: currency1}
  end

  test "check currency", state do
    assert is_nil(state.currency0)
    assert state.currency1 == "currencyTest"
  end
end
