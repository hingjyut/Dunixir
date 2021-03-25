defmodule Block.Validation.Local.BlockTimeTest do
  use ExUnit.Case
  doctest Block.Validation.Local.BlockTime

  @first_block %{
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
    "joiners" => ["DNann1Lh55eZMEDXeYt59bzHbA3NJR46DeQYCS2qQdLV:s2hUbokkibTAWGEwErw6hyXSWlWFQ2UWs2PWx8d/kkElAyuuWaQq4Tsonuweh1xn4AC1TVWt4yMR3WrDdkhnAw==:0-E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855:0-E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855:tic",
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

@random_block %{
  "version" => 10,
  "nonce" => 10_200_000_000_544,
  "number" => 89789,
  "powMin" => 61,
  "time" => 1_511_207_700,
  "medianTime" => 1_511_206_743,
  "membersCount" => 26,
  "monetaryMass" => 4_506_796,
  "unitbase" => 0,
  "issuersCount" => 5,
  "issuersFrame" => 26,
  "issuersFrameVar" => 0,
  "currency" => "g1-test",
  "issuer" => "68jjsRrrX6hzs4z6eK2A2MUGLdKPfysFd1n3DYfHr7X9",
  "signature" =>
    "bZ0yW/y8JPTuCA0k+pb9LQoWuFACh14QAew79mbOTUsyfdApuCkbFPoOErTPTsvqQdoi+Uf/6nyF6piRbwNVCw==",
  "hash" => "0000E9BEC445D0A4203568F34CE7B2879C52AB699BB4ED41C0870B0AEE39E5C2",
  "parameters" => "",
  "previousHash" => "0001E8442C934B9A90AADD817E98E813F5487D4F6A521411D7959E7FD21E265A",
  "previousIssuer" => "9Kjpr9VGoMLe3NYUkthPkEoZfxo3pGcs1g9i1H8SPNeL",
  "inner_hash" => "44D93C4483C749FBAE7954A49F276FCA8FB5141010B1EF7FAF20251A9C5B2DC8",
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
    "Version: 10\nType: Block\nCurrency: g1-test\nNumber: 89789\nPoWMin: 61\nTime: 1511207700\nMedianTime: 1511206743\nUnitBase: 0\nIssuer: 68jjsRrrX6hzs4z6eK2A2MUGLdKPfysFd1n3DYfHr7X9\nIssuersFrame: 26\nIssuersFrameVar: 0\nDifferentIssuersCount: 5\nPreviousHash: 0001E8442C934B9A90AADD817E98E813F5487D4F6A521411D7959E7FD21E265A\nPreviousIssuer: 9Kjpr9VGoMLe3NYUkthPkEoZfxo3pGcs1g9i1H8SPNeL\nMembersCount: 26\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nInnerHash: 44D93C4483C749FBAE7954A49F276FCA8FB5141010B1EF7FAF20251A9C5B2DC8\nNonce: 10200000000544\n"
}

alias Block.Validation.Local.BlockTime, as: BlockTime

test "Check first block time is correctly validated" do
  assert BlockTime.valid(@first_block)
end

test "Check that valid block time is correctly validated" do
  assert BlockTime.valid(@random_block)
end

end

