defmodule ConstantsRegexpTest do
  use ExUnit.Case
  doctest Dunixir

  test "ws2p regular expression test" do
    valid_enpoint1 = "WS2P c1c39a0a g1-monit.librelois.fr 443 ws2p"
    valid_endpoint2 = "WS2P a0a45ed2 88.174.120.187 20901"
    invalid_enpoint = "WS2P a0a45ed22 88.174.120.187 20901"
    assert Regex.compile!(Constants.ws2p_regexp) |> Regex.match?(valid_enpoint1)
    assert Regex.compile!(Constants.ws2p_regexp) |> Regex.match?(valid_endpoint2)
    assert Regex.compile!(Constants.ws2p_regexp) |> Regex.match?(invalid_enpoint) == false
  end

  test "public key regular expression test" do
    valid_pubkey = "AiaPR4hnQ3d3oZfEa6UJGiwUziRAzweNFuaoc5bSaupm"
    invalid_pubkey = "aAiaPR4hnQ3d3-ZfEa6UJGiwUziRAzweNFuaoc5bSaupm"
    assert Regex.compile!(Constants.pubkey_regexp) |> Regex.match?(valid_pubkey)
    assert Regex.compile!(Constants.pubkey_regexp) |> Regex.match?(invalid_pubkey) == false
  end

  test "block uid regular expression test" do
    blockstamp = "43835-00000D9316C6A4A1C236A0A3CA58FC007B75829981DA08A0633AA622E26F2421"
    assert Regex.compile!(Constants.block_uid_regexp) |> Regex.match?(blockstamp)
  end

end
