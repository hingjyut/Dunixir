defmodule NewComerTest do
  use ExUnit.Case
  # doctest NewComer

  @block_1 %{"number" => 1, "identities" => []}
  @block_2 %{"number" => 2, "identities"=> ["a","b"]}

  @table :blocks

  setup_all do
    t = :ets.new(@table, [:ordered_set, :named_table])
    :ets.insert(t, {1, @block_1})
    :ets.insert(t, {2, @block_2})
    :ok
  end

  def test(X) do
    if X["identities"] != [] do
      X["numbers"]
    end
  end

  test "identitied not empty" do
    # fun = :ets.fun2ms(fn {X} when X["identities"] != [] -> X["numbers"] end)
    fun = :ets.fun2ms(NewComerTest.test())
    assert [1] == :ets.select(@table, fun)
  end
end
