defmodule Block.Validation.Local.ParamTest do
  use ExUnit.Case
  doctest Block.Validation.Local.Parameters

  @block_with_parmeter_0 %{
    "version" => 10,
    "nonce" => 10_000_000_042_832,
    "number" => 100_000,
    "powMin" => 68,
    "time" => 1_512_784_574,
    "medianTime" => 1_512_782_695,
    "membersCount" => 28,
    "monetaryMass" => 5_372_168,
    "unitbase" => 0,
    "issuersCount" => 5,
    "issuersFrame" => 26,
    "issuersFrameVar" => 0,
    "currency" => "g1-test",
    "issuer" => "2RbXrLkmtgWMcis8NWhPvM7BAGT4xLK5mFRkHiYi2Vc7",
    "signature" =>
      "jKBDXZlyw3PGJ5KN+pk4Dcx15w1fsbYnDKOzIVuM7MJbsKS5cOvZBm2JM+hLECXOrx+U+iMPYLc0VXbho9EbDQ==",
    "hash" => "00008B17138B77EDDB855C0F7EFA50B973C9C031469EA76D32A90C08671B4445",
    "parameters" => "",
    "previousHash" => "0000249481FF9D6407A2716B4144CA0A3F1AACAF547974688D773851807DEC4F",
    "previousIssuer" => "68jjsRrrX6hzs4z6eK2A2MUGLdKPfysFd1n3DYfHr7X9",
    "inner_hash" => "FEC411D5138F0E85AD8FA5A4916DD167A123EEED9FE0A440FFC6A0C11350D551",
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
      "Version: 10\nType: Block\nCurrency: g1-test\nNumber: 100000\nPoWMin: 68\nTime: 1512784574\nMedianTime: 1512782695\nUnitBase: 0\nIssuer: 2RbXrLkmtgWMcis8NWhPvM7BAGT4xLK5mFRkHiYi2Vc7\nIssuersFrame: 26\nIssuersFrameVar: 0\nDifferentIssuersCount: 5\nPreviousHash: 0000249481FF9D6407A2716B4144CA0A3F1AACAF547974688D773851807DEC4F\nPreviousIssuer: 68jjsRrrX6hzs4z6eK2A2MUGLdKPfysFd1n3DYfHr7X9\nMembersCount: 28\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nInnerHash: FEC411D5138F0E85AD8FA5A4916DD167A123EEED9FE0A440FFC6A0C11350D551\nNonce: 10000000042832\n"
  }

  @block_with_parameter %{
    "version" => 11,
    "nonce" => 10_100_000_000_648,
    "number" => 0,
    "powMin" => 60,
    "time" => 1_546_252_844,
    "medianTime" => 1_546_248_548,
    "membersCount" => 17,
    "monetaryMass" => 63_086_194,
    "unitbase" => 1,
    "issuersCount" => 3,
    "issuersFrame" => 16,
    "issuersFrameVar" => 0,
    "currency" => "g1-test",
    "issuer" => "5B8iMAzq1dNmFe3ZxFTBQkqhq4fsztg1gZvxHXCk1XYH",
    "signature" =>
      "uICE+iZ0n9jhaDgkmv8T62EqzJPIc4GJo/JE/JCOFsfLkQT22Yh/05EHpBS4voXZZeoihzShijNkAJYhOmUtBQ==",
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
    "raw" =>
      "Version: 11\nType: Block\nCurrency: g1-test\nNumber: 300000\nPoWMin: 60\nTime: 1546252844\nMedianTime: 1546248548\nUnitBase: 1\nIssuer: 5B8iMAzq1dNmFe3ZxFTBQkqhq4fsztg1gZvxHXCk1XYH\nIssuersFrame: 16\nIssuersFrameVar: 0\nDifferentIssuersCount: 3\nPreviousHash: 0002375F02CCF23082A944C3A02CDB7899502114EA2731C681D3D39008B29D65\nPreviousIssuer: CaE9dyy4GLsZ1QoVziDXUDbxFyxM82PPPmTjYdjf2K7h\nMembersCount: 17\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nInnerHash: 87A0FE87B38BE8F5979131EA8564B944672CDFF8D5D228EEB733A7841ACB123F\nNonce: 10100000000648\n"
  }

  @block_with_invalid_parameter %{
    "version" => 11,
    "nonce" => 10_100_000_000_648,
    "number" => 20000,
    "powMin" => 60,
    "time" => 1_546_252_844,
    "medianTime" => 1_546_248_548,
    "membersCount" => 17,
    "monetaryMass" => 63_086_194,
    "unitbase" => 1,
    "issuersCount" => 3,
    "issuersFrame" => 16,
    "issuersFrameVar" => 0,
    "currency" => "g1-test",
    "issuer" => "5B8iMAzq1dNmFe3ZxFTBQkqhq4fsztg1gZvxHXCk1XYH",
    "signature" =>
      "uICE+iZ0n9jhaDgkmv8T62EqzJPIc4GJo/JE/JCOFsfLkQT22Yh/05EHpBS4voXZZeoihzShijNkAJYhOmUtBQ==",
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
    "raw" =>
      "Version: 11\nType: Block\nCurrency: g1-test\nNumber: 300000\nPoWMin: 60\nTime: 1546252844\nMedianTime: 1546248548\nUnitBase: 1\nIssuer: 5B8iMAzq1dNmFe3ZxFTBQkqhq4fsztg1gZvxHXCk1XYH\nIssuersFrame: 16\nIssuersFrameVar: 0\nDifferentIssuersCount: 3\nPreviousHash: 0002375F02CCF23082A944C3A02CDB7899502114EA2731C681D3D39008B29D65\nPreviousIssuer: CaE9dyy4GLsZ1QoVziDXUDbxFyxM82PPPmTjYdjf2K7h\nMembersCount: 17\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nInnerHash: 87A0FE87B38BE8F5979131EA8564B944672CDFF8D5D228EEB733A7841ACB123F\nNonce: 10100000000648\n"
  }

  alias Block.Validation.Local.Parameters, as: Parameters

  test "Validates block parameters" do
    assert Parameters.valid(@block_with_parameter)
    assert Parameters.valid(@block_with_parmeter_0)
  end

  test "Invalid block parameters" do
    refute Parameters.valid(@block_with_invalid_parameter)
  end
end
