defmodule Block.Validation.Local.TransactionNumberOfLinesTest do
  use ExUnit.Case
  doctest Block.Validation.Local.TransactionNumberOfLines

  @block %{
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
        ],
        "comment" => "cross1",
        "currency" => "duniter_unit_test_currency",
        "block_number" => 11,
        "time" => 1489679935
      }
    ]
  }

  alias Block.Validation.Local.TransactionNumberOfLines, as: TransactionNumberOfLines
  test "validates a block has less than 100 transactions" do
    assert TransactionNumberOfLines.valid(@block)
  end
end
