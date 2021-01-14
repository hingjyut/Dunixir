defmodule Block.Validation.Local.MembershipSigTest do
  use ExUnit.Case
  doctest Block.Validation.Local.MembershipSig

  @block_with_empty_joiners %{
    "version" => 11,
    "nonce" => 10100000000648,
    "number" => 0,
    "powMin" => 60,
    "time" => 1546252844,
    "medianTime" => 1546248548,
    "membersCount" => 17,
    "monetaryMass" => 63086194,
    "unitbase" => 1,
    "issuersCount" => 3,
    "issuersFrame" => 16,
    "issuersFrameVar" => 0,
    "currency" => "g1-test",
    "issuer" => "5B8iMAzq1dNmFe3ZxFTBQkqhq4fsztg1gZvxHXCk1XYH",
    "signature" => "uICE+iZ0n9jhaDgkmv8T62EqzJPIc4GJo/JE/JCOFsfLkQT22Yh/05EHpBS4voXZZeoihzShijNkAJYhOmUtBQ==",
    "hash" => "0001CC094C5A8717521506DF6002945E7F4350B6DBA9BFC782E8AC68E697CDA0",
    "parameters" => "wgsdryhgdreyh",
    "previousHash" => "0002375F02CCF23082A944C3A02CDB7899502114EA2731C681D3D39008B29D65",
    "previousIssuer" => "CaE9dyy4GLsZ1QoVziDXUDbxFyxM82PPPmTjYdjf2K7h",
    "inner_hash" => "87A0FE87B38BE8F5979131EA8564B944672CDFF8D5D228EEB733A7841ACB123F",
    "dividend" => nil,
    "identities" => [],
    "joiners" => [],
    "actives" => [],
    "leavers" => [],
    "revoked" => [],
    "excluded" => [],
    "certifications" => [],
    "transactions" => [],
    "raw" => "Version: 11\nType: Block\nCurrency: g1-test\nNumber: 300000\nPoWMin: 60\nTime: 1546252844\nMedianTime: 1546248548\nUnitBase: 1\nIssuer: 5B8iMAzq1dNmFe3ZxFTBQkqhq4fsztg1gZvxHXCk1XYH\nIssuersFrame: 16\nIssuersFrameVar: 0\nDifferentIssuersCount: 3\nPreviousHash: 0002375F02CCF23082A944C3A02CDB7899502114EA2731C681D3D39008B29D65\nPreviousIssuer: CaE9dyy4GLsZ1QoVziDXUDbxFyxM82PPPmTjYdjf2K7h\nMembersCount: 17\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nInnerHash: 87A0FE87B38BE8F5979131EA8564B944672CDFF8D5D228EEB733A7841ACB123F\nNonce: 10100000000648\n"
  }

  @block_with_joiner %{
    "version" => 11,
    "nonce" => 10100000000648,
    "number" => 20000,
    "powMin" => 60,
    "time" => 1546252844,
    "medianTime" => 1546248548,
    "membersCount" => 17,
    "monetaryMass" => 63086194,
    "unitbase" => 1,
    "issuersCount" => 3,
    "issuersFrame" => 16,
    "issuersFrameVar" => 0,
    "currency" => "g1-test",
    "issuer" => "5B8iMAzq1dNmFe3ZxFTBQkqhq4fsztg1gZvxHXCk1XYH",
    "signature" => "uICE+iZ0n9jhaDgkmv8T62EqzJPIc4GJo/JE/JCOFsfLkQT22Yh/05EHpBS4voXZZeoihzShijNkAJYhOmUtBQ==",
    "hash" => "0001CC094C5A8717521506DF6002945E7F4350B6DBA9BFC782E8AC68E697CDA0",
    "parameters" => "wgsdryhgdreyh",
    "previousHash" => "0002375F02CCF23082A944C3A02CDB7899502114EA2731C681D3D39008B29D65",
    "previousIssuer" => "CaE9dyy4GLsZ1QoVziDXUDbxFyxM82PPPmTjYdjf2K7h",
    "inner_hash" => "87A0FE87B38BE8F5979131EA8564B944672CDFF8D5D228EEB733A7841ACB123F",
    "dividend" => nil,
    "identities" => [],
    "joiners" => ["5ocqzyDMMWf1V8bsoNhWb1iNwax1e9M7VTUN6navs8of:RH+aBL2YP7g90G/ujN0ww1LXc+QiHGok6/CIlrQ3WWSE1rrWQhYIw4Fas+T56kxPvC3b6PDy8RBWt74TTTTqAg==:0-E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855:0-E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855:kimamila"],
    "actives" => [],
    "leavers" => [],
    "revoked" => [],
    "excluded" => [],
    "certifications" => [],
    "transactions" => [],
    "raw" => "Version: 11\nType: Block\nCurrency: g1-test\nNumber: 300000\nPoWMin: 60\nTime: 1546252844\nMedianTime: 1546248548\nUnitBase: 1\nIssuer: 5B8iMAzq1dNmFe3ZxFTBQkqhq4fsztg1gZvxHXCk1XYH\nIssuersFrame: 16\nIssuersFrameVar: 0\nDifferentIssuersCount: 3\nPreviousHash: 0002375F02CCF23082A944C3A02CDB7899502114EA2731C681D3D39008B29D65\nPreviousIssuer: CaE9dyy4GLsZ1QoVziDXUDbxFyxM82PPPmTjYdjf2K7h\nMembersCount: 17\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nInnerHash: 87A0FE87B38BE8F5979131EA8564B944672CDFF8D5D228EEB733A7841ACB123F\nNonce: 10100000000648\n"
  }

  alias Block.Validation.Local.MembershipSig, as: MemSig

  test "Validates with no joiners" do
    assert MemSig.valid(@block_with_empty_joiners)
  end

  test "Validates with single joiner" do
    assert MemSig.valid(@block_with_joiner)
  end
end
