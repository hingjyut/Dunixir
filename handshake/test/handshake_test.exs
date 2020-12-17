defmodule MyWebsocketApp.Test do
  use ExUnit.Case
  doctest MyWebsocketApp

  test "greets the world" do
    assert Handshake.hello() == :world
  end
end
