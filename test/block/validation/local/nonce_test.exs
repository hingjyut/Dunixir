defmodule Block.Validation.Local.NonceTest do
  use ExUnit.Case
  doctest Block.Validation.Local.Nonce

  alias Block.Validation.Local.Nonce, as: Nonce

  @block_with_high_nonce %{
    "version" => 10,
    "nonce" => 10_400_000_044_101,
    "number" => 4242,
    "powMin" => 64,
    "time" => 1_497_531_880,
    "medianTime" => 1_497_531_232,
    "membersCount" => 10,
    "monetaryMass" => 98000,
    "unitbase" => 0,
    "issuersCount" => 2,
    "issuersFrame" => 11,
    "issuersFrameVar" => 0,
    "currency" => "g1-test",
    "issuer" => "E8Ah8g9vpK7x52Bt4Mzmz9f2rdp7j1dxdgcGiSkpMJ4y",
    "signature" =>
      "lkN1eDClPBbAMgK1rA1ZaQS6ywCnnU9/zhXe4Gn/tFgfpFX7CEtI+CVfL7VZDIJv34NRCvlAhK3yPNL195K6Ag==",
    "hash" => "00009695F4FB676F5E1C94E59EA12F0043237636D339CEAD890DD9E35BA087D7",
    "parameters" => "",
    "previousHash" => "00000EA8DAB64E234404A7086BBE29848368EFE4BF5E52BB6B3DDEA29BAC7B0E",
    "previousIssuer" => "E8Ah8g9vpK7x52Bt4Mzmz9f2rdp7j1dxdgcGiSkpMJ4y",
    "inner_hash" => "787A9069279B6591DE759CA3E22502C464AE6924B15BF90AD8369874268ECF9D",
    "dividend" => nil,
    "identities" => [],
    "joiners" => [],
    "actives" => [],
    "leavers" => [],
    "revoked" => [],
    "excluded" => [],
    "certifications" => [],
    "transactions" => [],
    "raw" =>
      "Version: 10\nType: Block\nCurrency: g1-test\nNumber: 4242\nPoWMin: 64\nTime: 1497531880\nMedianTime: 1497531232\nUnitBase: 0\nIssuer: E8Ah8g9vpK7x52Bt4Mzmz9f2rdp7j1dxdgcGiSkpMJ4y\nIssuersFrame: 11\nIssuersFrameVar: 0\nDifferentIssuersCount: 2\nPreviousHash: 00000EA8DAB64E234404A7086BBE29848368EFE4BF5E52BB6B3DDEA29BAC7B0E\nPreviousIssuer: E8Ah8g9vpK7x52Bt4Mzmz9f2rdp7j1dxdgcGiSkpMJ4y\nMembersCount: 10\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nInnerHash: 787A9069279B6591DE759CA3E22502C464AE6924B15BF90AD8369874268ECF9D\nNonce: 10400000044101\n"
  }

  @block_with_zero_nonce %{
    "version" => 10,
    "nonce" => 0,
    "number" => 4242,
    "powMin" => 64,
    "time" => 1_497_531_880,
    "medianTime" => 1_497_531_232,
    "membersCount" => 10,
    "monetaryMass" => 98000,
    "unitbase" => 0,
    "issuersCount" => 2,
    "issuersFrame" => 11,
    "issuersFrameVar" => 0,
    "currency" => "g1-test",
    "issuer" => "E8Ah8g9vpK7x52Bt4Mzmz9f2rdp7j1dxdgcGiSkpMJ4y",
    "signature" =>
      "lkN1eDClPBbAMgK1rA1ZaQS6ywCnnU9/zhXe4Gn/tFgfpFX7CEtI+CVfL7VZDIJv34NRCvlAhK3yPNL195K6Ag==",
    "hash" => "00009695F4FB676F5E1C94E59EA12F0043237636D339CEAD890DD9E35BA087D7",
    "parameters" => "",
    "previousHash" => "00000EA8DAB64E234404A7086BBE29848368EFE4BF5E52BB6B3DDEA29BAC7B0E",
    "previousIssuer" => "E8Ah8g9vpK7x52Bt4Mzmz9f2rdp7j1dxdgcGiSkpMJ4y",
    "inner_hash" => "787A9069279B6591DE759CA3E22502C464AE6924B15BF90AD8369874268ECF9D",
    "dividend" => nil,
    "identities" => [],
    "joiners" => [],
    "actives" => [],
    "leavers" => [],
    "revoked" => [],
    "excluded" => [],
    "certifications" => [],
    "transactions" => [],
    "raw" =>
      "Version: 10\nType: Block\nCurrency: g1-test\nNumber: 4242\nPoWMin: 64\nTime: 1497531880\nMedianTime: 1497531232\nUnitBase: 0\nIssuer: E8Ah8g9vpK7x52Bt4Mzmz9f2rdp7j1dxdgcGiSkpMJ4y\nIssuersFrame: 11\nIssuersFrameVar: 0\nDifferentIssuersCount: 2\nPreviousHash: 00000EA8DAB64E234404A7086BBE29848368EFE4BF5E52BB6B3DDEA29BAC7B0E\nPreviousIssuer: E8Ah8g9vpK7x52Bt4Mzmz9f2rdp7j1dxdgcGiSkpMJ4y\nMembersCount: 10\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nInnerHash: 787A9069279B6591DE759CA3E22502C464AE6924B15BF90AD8369874268ECF9D\nNonce: 0\n"
  }

  @block_with_neg_nonce %{
    "version" => 10,
    "nonce" => -10_400_000_044_101,
    "number" => 4242,
    "powMin" => 64,
    "time" => 1_497_531_880,
    "medianTime" => 1_497_531_232,
    "membersCount" => 10,
    "monetaryMass" => 98000,
    "unitbase" => 0,
    "issuersCount" => 2,
    "issuersFrame" => 11,
    "issuersFrameVar" => 0,
    "currency" => "g1-test",
    "issuer" => "E8Ah8g9vpK7x52Bt4Mzmz9f2rdp7j1dxdgcGiSkpMJ4y",
    "signature" =>
      "lkN1eDClPBbAMgK1rA1ZaQS6ywCnnU9/zhXe4Gn/tFgfpFX7CEtI+CVfL7VZDIJv34NRCvlAhK3yPNL195K6Ag==",
    "hash" => "00009695F4FB676F5E1C94E59EA12F0043237636D339CEAD890DD9E35BA087D7",
    "parameters" => "",
    "previousHash" => "00000EA8DAB64E234404A7086BBE29848368EFE4BF5E52BB6B3DDEA29BAC7B0E",
    "previousIssuer" => "E8Ah8g9vpK7x52Bt4Mzmz9f2rdp7j1dxdgcGiSkpMJ4y",
    "inner_hash" => "787A9069279B6591DE759CA3E22502C464AE6924B15BF90AD8369874268ECF9D",
    "dividend" => nil,
    "identities" => [],
    "joiners" => [],
    "actives" => [],
    "leavers" => [],
    "revoked" => [],
    "excluded" => [],
    "certifications" => [],
    "transactions" => [],
    "raw" =>
      "Version: 10\nType: Block\nCurrency: g1-test\nNumber: 4242\nPoWMin: 64\nTime: 1497531880\nMedianTime: 1497531232\nUnitBase: 0\nIssuer: E8Ah8g9vpK7x52Bt4Mzmz9f2rdp7j1dxdgcGiSkpMJ4y\nIssuersFrame: 11\nIssuersFrameVar: 0\nDifferentIssuersCount: 2\nPreviousHash: 00000EA8DAB64E234404A7086BBE29848368EFE4BF5E52BB6B3DDEA29BAC7B0E\nPreviousIssuer: E8Ah8g9vpK7x52Bt4Mzmz9f2rdp7j1dxdgcGiSkpMJ4y\nMembersCount: 10\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nInnerHash: 787A9069279B6591DE759CA3E22502C464AE6924B15BF90AD8369874268ECF9D\nNonce: -10400000044101\n"
  }

  test "validates the nonce is non negative" do
    assert Nonce.valid(@block_with_high_nonce)
    assert Nonce.valid(@block_with_zero_nonce)
    refute Nonce.valid(@block_with_neg_nonce)
  end
end
