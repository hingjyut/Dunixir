defmodule BlockchainProcessorTest do
  use ExUnit.Case
  doctest BlockchainProcessor

  test "greets the world" do
    assert BlockchainProcessor.hello() == :world
  end
end
