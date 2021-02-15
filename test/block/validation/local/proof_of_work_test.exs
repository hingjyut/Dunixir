defmodule Block.Validation.Local.ProofOfWorkTest do
  use ExUnit.Case
  doctest Block.Validation.Local.ProofOfWork

  @block_valid_pow1 %{
    "version" => 11,
    "nonce" => 10_100_000_000_648,
    "number" => 300_000,
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
    "parameters" => "",
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

  @block_valid_pow2 %{
    "version" => 12,
    "nonce" => 10_000_000_000_667,
    "number" => 600_000,
    "powMin" => 45,
    "time" => 1_595_414_863,
    "medianTime" => 1_595_413_173,
    "membersCount" => 8,
    "monetaryMass" => 2_213_628_864,
    "unitbase" => 3,
    "issuersCount" => 4,
    "issuersFrame" => 21,
    "issuersFrameVar" => 0,
    "currency" => "g1-test",
    "issuer" => "5B8iMAzq1dNmFe3ZxFTBQkqhq4fsztg1gZvxHXCk1XYH",
    "signature" =>
      "4DLDlVXVDhJOcrnFdA60YMQ49euqmTY2ZJWEj2bd/PHYjfzJI3lqYkvAY8ew20fDYJtAwZvbtKHDlF+XysnRCQ==",
    "hash" => "0018186DE87C6FE4C6DBB8EB0C9B0650E9A8447B6A704957FE0220A855F49A93",
    "parameters" => "",
    "previousHash" => "000CA1650E05059F37C886ACEC28AA71F125CE5DC5F7AE77C107BF52DBFB747F",
    "previousIssuer" => "39YyHCMQNmXY7NkPCXXfzpV1vYct4GBxwgfyd4d72HmB",
    "inner_hash" => "B654D111FCE6EB76ADA91ADB21B0E80A1F68A1B558C962378C725DF8E1B3EE81",
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
      "Version: 12\nType: Block\nCurrency: g1-test\nNumber: 600000\nPoWMin: 45\nTime: 1595414863\nMedianTime: 1595413173\nUnitBase: 3\nIssuer: 5B8iMAzq1dNmFe3ZxFTBQkqhq4fsztg1gZvxHXCk1XYH\nIssuersFrame: 21\nIssuersFrameVar: 0\nDifferentIssuersCount: 4\nPreviousHash: 000CA1650E05059F37C886ACEC28AA71F125CE5DC5F7AE77C107BF52DBFB747F\nPreviousIssuer: 39YyHCMQNmXY7NkPCXXfzpV1vYct4GBxwgfyd4d72HmB\nMembersCount: 8\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nInnerHash: B654D111FCE6EB76ADA91ADB21B0E80A1F68A1B558C962378C725DF8E1B3EE81\nNonce: 10000000000667\n"
  }

  @block_invalid_pow %{
    "version" => 12,
    "nonce" => 10_000_000_000_667,
    "number" => 600_000,
    "powMin" => 45,
    "time" => 1_595_414_863,
    "medianTime" => 1_595_413_173,
    "membersCount" => 8,
    "monetaryMass" => 2_213_628_864,
    "unitbase" => 3,
    "issuersCount" => 4,
    "issuersFrame" => 21,
    "issuersFrameVar" => 0,
    "currency" => "g1-test",
    "issuer" => "5B8iMAzq1dNmFe3ZxFTBQkqhq4fsztg1gZvxHXCk1XYH",
    "signature" =>
      "4DLDlVXVDhJOcrnFdA60YMQ49euqmTY2ZJWEj2bd/PHYjfzJI3lqYkvAY8ew20fDYJtAwZvbtKHDlF+XysnRCQ==",
    "hash" => "018186DE87C6FE4C6DBB8EB0C9B0650E9A8447B6A704957FE0220A855F49A93",
    "parameters" => "",
    "previousHash" => "000CA1650E05059F37C886ACEC28AA71F125CE5DC5F7AE77C107BF52DBFB747F",
    "previousIssuer" => "39YyHCMQNmXY7NkPCXXfzpV1vYct4GBxwgfyd4d72HmB",
    "inner_hash" => "B654D111FCE6EB76ADA91ADB21B0E80A1F68A1B558C962378C725DF8E1B3EE81",
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
      "Version: 12\nType: Block\nCurrency: g1-test\nNumber: 600000\nPoWMin: 45\nTime: 1595414863\nMedianTime: 1595413173\nUnitBase: 3\nIssuer: 5B8iMAzq1dNmFe3ZxFTBQkqhq4fsztg1gZvxHXCk1XYH\nIssuersFrame: 21\nIssuersFrameVar: 0\nDifferentIssuersCount: 4\nPreviousHash: 000CA1650E05059F37C886ACEC28AA71F125CE5DC5F7AE77C107BF52DBFB747F\nPreviousIssuer: 39YyHCMQNmXY7NkPCXXfzpV1vYct4GBxwgfyd4d72HmB\nMembersCount: 8\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nInnerHash: B654D111FCE6EB76ADA91ADB21B0E80A1F68A1B558C962378C725DF8E1B3EE81\nNonce: 10000000000667\n"
  }

  alias Block.Validation.Local.ProofOfWork, as: ProofOfWork

  test "Check valid proof of works are correctly validated" do
    assert ProofOfWork.valid(@block_valid_pow1)
    assert ProofOfWork.valid(@block_valid_pow2)
  end

  test "Check invalid proof of works are correctly failed" do
    refute ProofOfWork.valid(@block_invalid_pow)
  end
end
