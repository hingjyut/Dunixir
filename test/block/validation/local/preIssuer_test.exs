defmodule Block.Validation.Local.PreIssuerTest do
  use ExUnit.Case
  doctest Block.Validation.Local.PreIssuer

  @block_with_version_10 %{
    "version" => 10,
    "nonce" => 10000000042832,
    "number" => 100000,
    "powMin" => 68,
    "time" => 1512784574,
    "medianTime" => 1512782695,
    "membersCount" => 28,
    "monetaryMass" => 5372168,
    "unitbase" => 0,
    "issuersCount" => 5,
    "issuersFrame" => 26,
    "issuersFrameVar" => 0,
    "currency" => "g1-test",
    "issuer" => "2RbXrLkmtgWMcis8NWhPvM7BAGT4xLK5mFRkHiYi2Vc7",
    "signature" => "jKBDXZlyw3PGJ5KN+pk4Dcx15w1fsbYnDKOzIVuM7MJbsKS5cOvZBm2JM+hLECXOrx+U+iMPYLc0VXbho9EbDQ==",
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
    "raw" => "Version: 10\nType: Block\nCurrency: g1-test\nNumber: 100000\nPoWMin: 68\nTime: 1512784574\nMedianTime: 1512782695\nUnitBase: 0\nIssuer: 2RbXrLkmtgWMcis8NWhPvM7BAGT4xLK5mFRkHiYi2Vc7\nIssuersFrame: 26\nIssuersFrameVar: 0\nDifferentIssuersCount: 5\nPreviousHash: 0000249481FF9D6407A2716B4144CA0A3F1AACAF547974688D773851807DEC4F\nPreviousIssuer: 68jjsRrrX6hzs4z6eK2A2MUGLdKPfysFd1n3DYfHr7X9\nMembersCount: 28\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nInnerHash: FEC411D5138F0E85AD8FA5A4916DD167A123EEED9FE0A440FFC6A0C11350D551\nNonce: 10000000042832\n"
  }

  alias Block.Validation.Local.PreIssuer, as: PreIssuer

  test "validates block previous issuer" do
    assert PreIssuer.valid(@block_with_version_10)
  end
end
