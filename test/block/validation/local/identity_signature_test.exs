defmodule Block.Validation.Local.IdentitySignatureTest do
  use ExUnit.Case
  doctest Block.Validation.Local.IdentitySignature

  @block_with_valid_identity_signature %{
    "version" => 10,
    "nonce" => 100_000_000_001,
    "number" => 0,
    "powMin" => 0,
    "time" => 1_489_672_122,
    "medianTime" => 1_489_672_122,
    "membersCount" => 2,
    "monetaryMass" => nil,
    "unitBase" => 0,
    "issuersCount" => 0,
    "issuersFrame" => 1,
    "issuersFrameVar" => 0,
    "len" => 6,
    "currency" => "duniter_unit_test_currency",
    "issuer" => "DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV",
    "signature" =>
      "N+x0F9pUcFTeqU3KEvmjGaPjnWt2uWkWCO43VXsBYCLCrjKkwU0EqJouETQKeQ7t7ukOiOyIrXW7+JBbzXaIBQ==",
    "hash" => "D06BB9FEE8D9E59892283D96A6B4D7B3937A177FB1F2B435A60E949099837355",
    "parameters" =>
      "0.007376575:3600:1200:0:40:604800:31536000:1:604800:604800:0.9:31536000:3:20:960:10:0.6666666666666666:1489675722:1489675722:3600",
    "previousHash" => nil,
    "previousIssuer" => nil,
    "inner_hash" => "C7DED079D6093B6E1210061D7EB43C7F006C6F656EF35A4F60E80B7B3CCBD989",
    "dividend" => nil,
    "identities" => [
      "DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV:1eubHHbuNfilHMM0G2bI30iZzebQ2cQ1PC7uPAw08FGMMmQCRerlF/3pc4sAcsnexsxBseA/3lY03KlONqJBAg==:0-E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855:tic",
      "DKpQPUL4ckzXYdnDRvCRKAm1gNvSdmAXnTrJZ7LvM5Qo:lcekuS0eP2dpFL99imJcwvDAwx49diiDMkG8Lj7FLkC/6IJ0tgNjUzCIZgMGi7bL5tODRiWi9B49UMXb8b3MAw==:0-E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855:toc"
    ],
    "joiners" => [
      "DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV:s2hUbokkibTAWGEwErw6hyXSWlWFQ2UWs2PWx8d/kkElAyuuWaQq4Tsonuweh1xn4AC1TVWt4yMR3WrDdkhnAw==:0-E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855:0-E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855:tic",
      "DKpQPUL4ckzXYdnDRvCRKAm1gNvSdmAXnTrJZ7LvM5Qo:80pUx9YBk0RwqrVrQQA+PuxoNn21A8NwQ3824CQPU1ad9R1oDXc/pU6NVpQv92LM8gaWs/Pm1mLXNNVnr+m6BA==:0-E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855:0-E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855:toc"
    ],
    "actives" => [],
    "leavers" => [],
    "revoked" => [],
    "excluded" => [],
    "certifications" => [
      "DKpQPUL4ckzXYdnDRvCRKAm1gNvSdmAXnTrJZ7LvM5Qo:DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV:0:vMaYgBSnU+83AYOVQCZAx1XLpg/F1MmMztDfCnZvl8hPs4LE9tcDvCrrFogAwMEW2N7Y0gCH62/fBMgw4KrGCA==",
      "DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV:DKpQPUL4ckzXYdnDRvCRKAm1gNvSdmAXnTrJZ7LvM5Qo:0:RKIGMgYIhB9FmjPbmyo4egPufg/iTpBznYGZp5hjK1WZ1a9imQldLNUMe0eiPlSKJTK/JD3gOlCiynOEY2csBA=="
    ],
    "transactions" => []
  }

  @block_with_invalid_identity_signature %{
    "version" => 10,
    "nonce" => 100_000_000_001,
    "number" => 0,
    "powMin" => 0,
    "time" => 1_489_672_122,
    "medianTime" => 1_489_672_122,
    "membersCount" => 2,
    "monetaryMass" => nil,
    "unitBase" => 0,
    "issuersCount" => 0,
    "issuersFrame" => 1,
    "issuersFrameVar" => 0,
    "len" => 6,
    "currency" => "duniter_unit_test_currency",
    "issuer" => "DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV",
    "signature" =>
      "N+x0F9pUcFTeqU3KEvmjGaPjnWt2uWkWCO43VXsBYCLCrjKkwU0EqJouETQKeQ7t7ukOiOyIrXW7+JBbzXaIBQ==",
    "hash" => "D06BB9FEE8D9E59892283D96A6B4D7B3937A177FB1F2B435A60E949099837355",
    "parameters" =>
      "0.007376575:3600:1200:0:40:604800:31536000:1:604800:604800:0.9:31536000:3:20:960:10:0.6666666666666666:1489675722:1489675722:3600",
    "previousHash" => nil,
    "previousIssuer" => nil,
    "inner_hash" => "C7DED079D6093B6E1210061D7EB43C7F006C6F656EF35A4F60E80B7B3CCBD989",
    "dividend" => nil,
    "identities" => [
      "DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV:1eubHHbuNfilHMM0G2bI30iZzebQ2cQ1PC7uPAw08FGMMmQCRerlF/3pc4sAcsnexsxBseA/3lY03KlONqJBAg==:0-E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855:tic",
      "AKpQPUL4ckzXYdnDRvCRKAm1gNvSdmAXnTrJZ7LvM5Qo:lcekuS0eP2dpFL99imJcwvDAwx49diiDMkG8Lj7FLkC/6IJ0tgNjUzCIZgMGi7bL5tODRiWi9B49UMXb8b3MAw==:0-E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855:toc"
    ],
    "joiners" => [
      "DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV:s2hUbokkibTAWGEwErw6hyXSWlWFQ2UWs2PWx8d/kkElAyuuWaQq4Tsonuweh1xn4AC1TVWt4yMR3WrDdkhnAw==:0-E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855:0-E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855:tic",
      "DKpQPUL4ckzXYdnDRvCRKAm1gNvSdmAXnTrJZ7LvM5Qo:80pUx9YBk0RwqrVrQQA+PuxoNn21A8NwQ3824CQPU1ad9R1oDXc/pU6NVpQv92LM8gaWs/Pm1mLXNNVnr+m6BA==:0-E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855:0-E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855:toc"
    ],
    "actives" => [],
    "leavers" => [],
    "revoked" => [],
    "excluded" => [],
    "certifications" => [
      "DKpQPUL4ckzXYdnDRvCRKAm1gNvSdmAXnTrJZ7LvM5Qo:DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV:0:vMaYgBSnU+83AYOVQCZAx1XLpg/F1MmMztDfCnZvl8hPs4LE9tcDvCrrFogAwMEW2N7Y0gCH62/fBMgw4KrGCA==",
      "DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV:DKpQPUL4ckzXYdnDRvCRKAm1gNvSdmAXnTrJZ7LvM5Qo:0:RKIGMgYIhB9FmjPbmyo4egPufg/iTpBznYGZp5hjK1WZ1a9imQldLNUMe0eiPlSKJTK/JD3gOlCiynOEY2csBA=="
    ],
    "transactions" => []
  }

  alias Block.Validation.Local.IdentitySignature, as: IdentitySignature

  test "Check that valid identities signatures are correctly validated" do
    assert IdentitySignature.valid(@block_with_valid_identity_signature)
  end

  test "Check that invalid identities signatures are correctly refused" do
    refute IdentitySignature.valid(@block_with_invalid_identity_signature)
  end
end
