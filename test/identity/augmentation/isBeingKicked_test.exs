defmodule Identity.Augmentation.IsBeingKicked do
  use ExUnit.Case

  doctest Index.Augmentation.IIndex

  setup_all do
    :file.delete("test/local_iindex")
    local_iindex = :ets.new(:"test/local_iindex", [:set, :protected])

    :ets.insert(local_iindex, {1, %{member: false}})
    Index.Augmentation.IIndex.isBeingKicked(local_iindex, 1)
    [{1, entry}] = :ets.lookup(local_iindex, 1)
    iskicked = entry.isBeingKicked

    :ets.insert(local_iindex, {0, %{member: true}})
    Index.Augmentation.IIndex.isBeingKicked(local_iindex, 0)
    [{0, entry}] = :ets.lookup(local_iindex, 0)
    isnotekicked = entry.isBeingKicked

    :dets.close(local_iindex)
    :file.delete("test/local_iindex")

    {:ok, iskicked: iskicked, isnotekicked: isnotekicked}
  end

  test "check isBeingKicked", state do
    assert state.iskicked == true
    assert state.isnotekicked == false
  end
end
