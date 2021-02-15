defmodule Block.Validation.Local.TransactionInputTest do
  use ExUnit.Case

  doctest Block.Validation.Local.TransactionInput

  @block_with_input_1 %{
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

  @block_with_input_2 %{
    "version" => 12,
    "nonce" => 10_000_000_000_667,
    "number" => 0,
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
    "parameters" => "egfs<egezsrg",
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
    "transactions" => [
      %{
        "version" => 10,
        "blockstamp" => "7-C5B4179C5D65DB6AF1D24CD6859D88C3B4A4A9DAD6A35AF32DA74D877816C0BB",
        "locktime" => 0,
        "issuers" => ["DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV"],
        "inputs" => [
          " =>0 =>T =>E14CB52BD5C9A4B9CA8D3007EABBB5B77E1F58D4598CC44D022AE398E4C8F90D =>0"
        ],
        "unlocks" => ["0 =>XHX(1872767826647264)"],
        "outputs" => ["1200 =>0 =>SIG(DKpQPUL4ckzXYdnDRvCRKAm1gNvSdmAXnTrJZ7LvM5Qo)"],
        "comments" => ["okk"],
        "signatures" => [
          "+KUFhYV5wpPbahhRtGcFVfWcjTh/Rl7K68i/ESKmrwf3rnFLpl4atVpzyvmsOsliz5wDjWMiG9wTYMDjRj4XDQ=="
        ],
        "comment" => "okk",
        "currency" => "duniter_unit_test_currency",
        "block_number" => 9,
        "time" => 1_489_679_935
      }
    ]
  }

  @block_with_input_3 %{
    "version" => 10,
    "nonce" => 200_000_000_001,
    "number" => 11,
    "powMin" => 1,
    "time" => 1_489_679_935,
    "medianTime" => 1_489_679_935,
    "membersCount" => 2,
    "monetaryMass" => 4800,
    "unitbase" => 0,
    "issuersCount" => 1,
    "issuersFrame" => 6,
    "issuersFrameVar" => 0,
    "len" => 8,
    "currency" => "duniter_unit_test_currency",
    "issuer" => "DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV",
    "signature" =>
      "OjWOEdPEpzWKFqxdIcSdk0FUcsXk3vAu9rcmucktgF1L8CdSh09Te4Aek8MCQ8vE7no+EJkL7QR6bv2tI8e/Dw==",
    "hash" => "7F2151494087FA237E1E793EA8C2D015B84A11492CAA282A44DC99DBB1DBAAC8",
    "parameters" => "",
    "previousHash" => "3524C70AAA67384D9627B0E79D2642DBB0402EF86B6205EC6AFC1EA20C6B5D92",
    "previousIssuer" => "DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV",
    "inner_hash" => "03E45A377A6BCDAA8AC8150A60EFB668C85068A7180C7524818CE331EFEC9ABC",
    "dividend" => nil,
    "identities" => [],
    "joiners" => [],
    "actives" => [],
    "leavers" => [],
    "revoked" => [],
    "excluded" => [],
    "certifications" => [],
    "transactions" => [
      %{
        "version" => 9,
        "blockstamp" => "10-3524C70AAA67384D9627B0E79D2642DBB0402EF86B6205EC6AFC1EA20C6B5D92",
        "locktime" => 0,
        "issuers" => [
          "DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV"
        ],
        "inputs" => [
          ""
        ],
        "unlocks" => [
          "0 =>SIG(0)"
        ],
        "outputs" => [
          "1200 =>0 =>(XHX(8AFC8DF633FC158F9DB4864ABED696C1AA0FE5D617A7B5F7AB8DE7CA2EFCD4CB) && SIG(DKpQPUL4ckzXYdnDRvCRKAm1gNvSdmAXnTrJZ7LvM5Qo)) || (SIG(DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV) && SIG(DKpQPUL4ckzXYdnDRvCRKAm1gNvSdmAXnTrJZ7LvM5Qo))"
        ],
        "comments" => [
          "cross1"
        ],
        "signatures" => [
          "qu+yUzggT+Zt6v4LpgVSYnJkTQRMUAmX4EOfsCnaVNROlv3QhhErynq+WGLNUbGSBnGtrwgA4VfjcZ0eTTL2CA=="
        ],
        "comment" => "cross1",
        "currency" => "duniter_unit_test_currency",
        "block_number" => 11,
        "time" => 1_489_679_935
      }
    ]
  }

  alias Block.Validation.Local.TransactionInput, as: TxInput

  test "Validates block input" do
    assert TxInput.valid(@block_with_input_1)
    assert TxInput.valid(@block_with_input_2)
    refute TxInput.valid(@block_with_input_3)
  end
end
