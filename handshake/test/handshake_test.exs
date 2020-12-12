defmodule HandshakeTest do
  use ExUnit.Case
  doctest Handshake

  test "greets the world" do
    assert Handshake.hello() == :world
  end
end
