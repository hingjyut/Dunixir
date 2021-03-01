defmodule Block.Augmentation.Head.UnitBaseTest do
  use ExUnit.Case

  doctest Index.Augmentation.BIndex

  setup_all do
    # create a local_bindex table
    local_bindex = :ets.new(:local_bindex, [:set, :protected])
    :ets.insert(local_bindex, {0, %{number: 0}})

    # create an empty global_bindex table
    :file.delete("test/global_bindex")
    {:ok, global_bindex} = :dets.open_file(:"test/global_bindex", type: :set)

    ################## TEST FOR unitBaseBR_G12 #####################
    Index.Augmentation.BIndex.unitBaseBR_G12(global_bindex, local_bindex)
    [{0, head}] = :ets.lookup(local_bindex, 0)
    unit_base0 = head.unitBase

    :ets.insert(local_bindex, {0, %{number: 1}})
    :dets.insert(global_bindex, {0, %{number: 0, unitBase: 5}})

    Index.Augmentation.BIndex.unitBaseBR_G12(global_bindex, local_bindex)
    [{0, head}] = :ets.lookup(local_bindex, 0)
    unit_base1 = head.unitBase

    ################## TEST FOR dividend #####################
    # :ets.insert(local_bindex, {0, %{number: 0, }})
    # :dets.insert(global_bindex, {0, %{number: 0, unitBase: 5}})


    :dets.close(global_bindex)
    :file.delete("test/global_bindex")

    {:ok, unit_base0: unit_base0, unit_base1: unit_base1}
  end

  test "check unitBase BR_G12", state do
    assert state.unit_base0 == 0
    assert state.unit_base1 == 5
  end
end
