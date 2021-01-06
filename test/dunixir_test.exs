defmodule DunixirTest do
  use ExUnit.Case
  doctest Dunixir

  test "greets the world" do
    assert Dunixir.hello() == :world
  end
end
