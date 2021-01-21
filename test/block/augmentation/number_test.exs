defmodule Block.Augmentation.Number do
  use ExUnit.Case

  doctest Index.Augmentation.BIndex

  setup_all  do

    local_bindex = :ets.new(:local_bindex,[:set,:protected])
    :ets.insert(local_bindex, {0, %{pub: "pub"}})

    :file.delete("test/global_bindex")
    {:ok, global_bindex} = :dets.open_file(:"test/global_bindex", [type: :set])

    Index.Augmentation.BIndex.number(global_bindex, local_bindex)
    [{0, head_vide}] = :ets.lookup(local_bindex, 0)
    [{:last_block, last_block_vide}] = :dets.lookup(global_bindex, :last_block)
    Index.Augmentation.BIndex.number(global_bindex, local_bindex)
    [{0, head_nonvide}] = :ets.lookup(local_bindex, 0)
    [{:last_block, last_block_nonvide}] = :dets.lookup(global_bindex, :last_block)

    :dets.close(global_bindex)
    :file.delete("test/global_bindex")

    {:ok, number_vide: head_vide.number, number_nonvide: head_nonvide.number, last_block_vide: last_block_vide, last_block_nonvide: last_block_nonvide}
  end

  test "check number",state do
    assert state.number_vide == 0
    assert state.number_nonvide == 1
    assert state.last_block_vide == 0
    assert state.last_block_nonvide == 1
  end


end
