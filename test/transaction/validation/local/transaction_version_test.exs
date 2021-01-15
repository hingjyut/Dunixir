defmodule Block.Validation.Local.TransactionVersionTest do
  use ExUnit.Case
  doctest Block.Validation.Local.TransactionVersion

  @transaction_with_version_10 %{
    "version" => 10,
    "nonce" => 200000000001,
    "number" => 9,
    "powMin" => 0,
    "time" => 1489679935,
    "medianTime" => 1489679935,
    "membersCount" => 2,
    "monetaryMass" => 4800,
    "unitbase" => 0,
    "issuersCount" => 1,
    "issuersFrame" => 6,
    "issuersFrameVar" => 0,
    "len" => 8,
    "currency" => "duniter_unit_test_currency",
    "issuer" => "DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV",
    "signature" => "/Fy/99YjcYvSCLWzcEGt55/14slANHNjupxSJ6kpZg3jK4fO6JXvAEshw73FVZ7sKYh+Hj0W840UsUaymVmUCg==",
    "hash" => "F2F5CC139B9BEF01E639198CB3A1203D5148E75DD072F5BB3D733A206F7C2DD6",
    "parameters" => "",
    "previousHash" => "E457BF313F313D6A852685BE741B1370B8B9C768C76D0F8A8711D7C5195461D2",
    "previousIssuer" => "DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV",
    "inner_hash" => "B4847747FF4D4A56B6AA778A096D30F16FBEA8D37D0AC4DE2C72E55CA2B68599",
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
        "inputs" => ["1200 =>0 =>T =>E14CB52BD5C9A4B9CA8D3007EABBB5B77E1F58D4598CC44D022AE398E4C8F90D =>0"],
        "unlocks" => ["0 =>XHX(1872767826647264)"],
        "outputs" => ["1200 =>0 =>SIG(DKpQPUL4ckzXYdnDRvCRKAm1gNvSdmAXnTrJZ7LvM5Qo)"],
        "comments" => ["okk"],
        "signatures" => ["+KUFhYV5wpPbahhRtGcFVfWcjTh/Rl7K68i/ESKmrwf3rnFLpl4atVpzyvmsOsliz5wDjWMiG9wTYMDjRj4XDQ=="],
        "comment" => "okk",
        "currency" => "duniter_unit_test_currency",
        "block_number" => 9,
        "time" => 1489679935
      }
    ]
  }

  @transaction_with_version_11 %{
    "version" => 10,
    "nonce" => 100000000001,
    "number" => 10,
    "powMin" => 1,
    "time" => 1489679935,
    "medianTime" => 1489679935,
    "membersCount" => 2,
    "monetaryMass" => 4800,
    "unitbase" => 0,
    "issuersCount" => 1,
    "issuersFrame" => 6,
    "issuersFrameVar" => 0,
    "len" => 7,
    "currency" => "duniter_unit_test_currency",
    "issuer" => "DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV",
    "signature" => "alJqiw4mWCy2cN8rsVV89J31El8msp2j5zTkFcNTP5M39sLOTwAJaL+orpPcmW28zRRIFpDssiQjys3t+3pHBg==",
    "hash" => "3524C70AAA67384D9627B0E79D2642DBB0402EF86B6205EC6AFC1EA20C6B5D92",
    "parameters" => "",
    "previousHash" => "F2F5CC139B9BEF01E639198CB3A1203D5148E75DD072F5BB3D733A206F7C2DD6",
    "previousIssuer" => "DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV",
    "inner_hash" => "6F8DFC7DF1889161DD0712A5CD19CA7BD437C4108AFDE8B9BA3838FA2283ADCD",
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
        "version" => 11,
        "blockstamp" => "9-F2F5CC139B9BEF01E639198CB3A1203D5148E75DD072F5BB3D733A206F7C2DD6",
        "locktime" => 0,
        "issuers" => [
          "DKpQPUL4ckzXYdnDRvCRKAm1gNvSdmAXnTrJZ7LvM5Qo"
        ],
        "inputs" => [
          "1200 =>0 =>T =>0E7786FE197AED43CFC607435707B1CD1C1C5A48F85EE9FC8D1DFA465190940D =>0"
        ],
        "unlocks" => [
          "0 =>SIG(0)"
        ],
        "outputs" => [
          "1200 =>0 =>SIG(DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV)"
        ],
        "comments" => [],
        "signatures" => [
          "zeENt6T/6XNIkxPswRniGotX8/Ob3StWNRiRphP/vKiyFUZZOnUCvVCFQ8+WD1iH2sl0siHG8ztn8AoZq/ZUDQ=="
        ],
        "comment" => "",
        "currency" => "duniter_unit_test_currency",
        "block_number" => 10,
        "time" => 1489679935
      }
    ]
  }
  @transaction_with_version_9 %{
    "version" => 10,
    "nonce" => 200000000001,
    "number" => 11,
    "powMin" => 1,
    "time" => 1489679935,
    "medianTime" => 1489679935,
    "membersCount" => 2,
    "monetaryMass" => 4800,
    "unitbase" => 0,
    "issuersCount" => 1,
    "issuersFrame" => 6,
    "issuersFrameVar" => 0,
    "len" => 8,
    "currency" => "duniter_unit_test_currency",
    "issuer" => "DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV",
    "signature" => "OjWOEdPEpzWKFqxdIcSdk0FUcsXk3vAu9rcmucktgF1L8CdSh09Te4Aek8MCQ8vE7no+EJkL7QR6bv2tI8e/Dw==",
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
          "1200 =>0 =>T =>1F3F5DCAA471431680CD7F5A59D3D22A1A1091810FC72D8BDE2A40883CD6D48D =>0"
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
        "time" => 1489679935
      }
    ]
  }
  alias Block.Validation.Local.TransactionVersion, as: TransactionVersion
  test "validates transaction version is equal 10" do
    assert TransactionVersion.valid(@transaction_with_version_10)
    refute TransactionVersion.valid(@transaction_with_version_9)
    refute TransactionVersion.valid(@transaction_with_version_11)
  end


end