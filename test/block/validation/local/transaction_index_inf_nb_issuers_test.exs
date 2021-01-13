defmodule Block.Validation.Local.TxInfNbIssuersTest do
  use ExUnit.Case
  doctest Block.Validation.Local.TxInfNbIssuers

  alias Block.Validation.Local.TxInfNbIssuers, as: TxInfNbIssuers

  @block_no_tx %{"version"=> 10,
   "nonce"=> 10400000044101,
   "number"=> 4242,
   "powMin"=> 64,
   "time"=> 1497531880,
   "medianTime"=> 1497531232,
   "membersCount"=> 10,
   "monetaryMass"=> 98000,
   "unitbase"=> 0,
   "issuersCount"=> 2,
   "issuersFrame"=> 11,
   "issuersFrameVar"=> 0,
   "currency"=> "g1-test",
   "issuer"=> "E8Ah8g9vpK7x52Bt4Mzmz9f2rdp7j1dxdgcGiSkpMJ4y",
   "signature"=> "lkN1eDClPBbAMgK1rA1ZaQS6ywCnnU9/zhXe4Gn/tFgfpFX7CEtI+CVfL7VZDIJv34NRCvlAhK3yPNL195K6Ag==",
   "hash"=> "00009695F4FB676F5E1C94E59EA12F0043237636D339CEAD890DD9E35BA087D7",
   "parameters"=> "",
   "previousHash"=> "00000EA8DAB64E234404A7086BBE29848368EFE4BF5E52BB6B3DDEA29BAC7B0E",
   "previousIssuer"=> "E8Ah8g9vpK7x52Bt4Mzmz9f2rdp7j1dxdgcGiSkpMJ4y",
   "inner_hash"=> "787A9069279B6591DE759CA3E22502C464AE6924B15BF90AD8369874268ECF9D",
   "dividend"=> nil,
   "identities"=> [],
   "joiners"=> [],
   "actives"=> [],
   "leavers"=> [],
   "revoked"=> [],
   "excluded"=> [],
   "certifications"=> [],
   "transactions"=> [],
   "raw"=> "Version: 10\nType: Block\nCurrency: g1-test\nNumber: 4242\nPoWMin: 64\nTime: 1497531880\nMedianTime: 1497531232\nUnitBase: 0\nIssuer: E8Ah8g9vpK7x52Bt4Mzmz9f2rdp7j1dxdgcGiSkpMJ4y\nIssuersFrame: 11\nIssuersFrameVar: 0\nDifferentIssuersCount: 2\nPreviousHash: 00000EA8DAB64E234404A7086BBE29848368EFE4BF5E52BB6B3DDEA29BAC7B0E\nPreviousIssuer: E8Ah8g9vpK7x52Bt4Mzmz9f2rdp7j1dxdgcGiSkpMJ4y\nMembersCount: 10\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nInnerHash: 787A9069279B6591DE759CA3E22502C464AE6924B15BF90AD8369874268ECF9D\nNonce: 10400000044101\n"
  }

  @block_one_tx_one_issuer %{"version" => 10,
  "nonce" => 10300000071384,
  "number" => 100,
  "powMin" => 78,
  "time" => 1489003535,
  "medianTime" => 1488999490,
  "membersCount" => 59,
  "monetaryMass" => 59000,
  "unitbase" => 0,
  "issuersCount" => 10,
  "issuersFrame" => 41,
  "issuersFrameVar" => 10,
  "currency" => "g1",
  "issuer" => "Be1eVp7etVfA7cT6er6dcJ9d5KxGJVY2tzCGGCAz3yG",
  "signature" => "2/1Qk5ekJL9BUMnW2j6AMR0wGuGgBkU4UWGumKYOyy/k7c5ZqhskLhsERWf47wocjyL9QBvQDDy3S8P9dXA5CA==",
  "hash" => "00000E2C80F67FDCF0A0BA975FF7A7025FDA3B51EE1365CFABC468EAC070D5AD",
  "parameters" => "",
  "previousHash" => "000012AD496ECA56DE0B8E5D6F749B7CBE78553E6385333A44E04377EFFCCA53",
  "previousIssuer" => "GfKERHnJTYzKhKUma5h1uWhetbA8yHKymhVH2raf2aCP",
  "inner_hash" => "A43FDA346B087982647C6F85851B2CAC6A726D0D4039C3D140AE6190B1145513",
  "dividend" => nil,
  "identities" => [],
  "joiners" => [],
  "actives" => [],
  "leavers" => [],
  "revoked" => [],
  "excluded" => [],
  "certifications" => [],
  "transactions" => [
  %{"version" => 10,
   "currency" => "g1",
   "locktime" => 0,
   "hash" => "4CDFE3315CE4ED198CBB7867DEDDAE15250DD8F094555778E9A1CC1545047A84",
   "blockstamp" => "98-000008CD42C3D493BED61C52482BCB3288DAF9A5F6FD253C07979716D0B7EFAC",
   "blockstampTime" => 1488998917,
   "issuers" => ["D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx"],
   "inputs" => ["1000:0:D:D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx:1"],
   "outputs" => ["500:0:SIG(2ny7YAdmzReQxAayyJZsyVYwYhVyax2thKcGknmQy5nQ)",
   "500:0:SIG(D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx)"],
   "unlocks" => ["0:SIG(0)"],
   "signatures" => ["CvfE2MawgbsHC6FM8IDEWZG7t55RDlaPpff7DdipGJ0mjFwC1s/+S3H7UURZ6wcEgndXQt/fZTx1wQz9A1zaDA=="],
   "comment" => "Merci pour toutes ces annees de dev pour les monnaies libres"
  }
  ],
  "raw" => "Version: 10\nType: Block\nCurrency: g1\nNumber: 100\nPoWMin: 78\nTime: 1489003535\nMedianTime: 1488999490\nUnitBase: 0\nIssuer: Be1eVp7etVfA7cT6er6dcJ9d5KxGJVY2tzCGGCAz3yG\nIssuersFrame: 41\nIssuersFrameVar: 10\nDifferentIssuersCount: 10\nPreviousHash: 000012AD496ECA56DE0B8E5D6F749B7CBE78553E6385333A44E04377EFFCCA53\nPreviousIssuer: GfKERHnJTYzKhKUma5h1uWhetbA8yHKymhVH2raf2aCP\nMembersCount: 59\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nTX:10:1:1:1:2:1:0\n98-000008CD42C3D493BED61C52482BCB3288DAF9A5F6FD253C07979716D0B7EFAC\nD9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx\n1000:0:D:D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx:1\n0:SIG(0)\n500:0:SIG(2ny7YAdmzReQxAayyJZsyVYwYhVyax2thKcGknmQy5nQ)\n500:0:SIG(D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx)\nMerci pour toutes ces annees de dev pour les monnaies libres\nCvfE2MawgbsHC6FM8IDEWZG7t55RDlaPpff7DdipGJ0mjFwC1s/+S3H7UURZ6wcEgndXQt/fZTx1wQz9A1zaDA==\nInnerHash: A43FDA346B087982647C6F85851B2CAC6A726D0D4039C3D140AE6190B1145513\nNonce: 10300000071384\n"
  }

@block_one_tx_many_issuers %{"version" => 10,
  "nonce" => 10300000071384,
  "number" => 100,
  "powMin" => 78,
  "time" => 1489003535,
  "medianTime" => 1488999490,
  "membersCount" => 59,
  "monetaryMass" => 59000,
  "unitbase" => 0,
  "issuersCount" => 10,
  "issuersFrame" => 41,
  "issuersFrameVar" => 10,
  "currency" => "g1",
  "issuer" => "Be1eVp7etVfA7cT6er6dcJ9d5KxGJVY2tzCGGCAz3yG",
  "signature" => "2/1Qk5ekJL9BUMnW2j6AMR0wGuGgBkU4UWGumKYOyy/k7c5ZqhskLhsERWf47wocjyL9QBvQDDy3S8P9dXA5CA==",
  "hash" => "00000E2C80F67FDCF0A0BA975FF7A7025FDA3B51EE1365CFABC468EAC070D5AD",
  "parameters" => "",
  "previousHash" => "000012AD496ECA56DE0B8E5D6F749B7CBE78553E6385333A44E04377EFFCCA53",
  "previousIssuer" => "GfKERHnJTYzKhKUma5h1uWhetbA8yHKymhVH2raf2aCP",
  "inner_hash" => "A43FDA346B087982647C6F85851B2CAC6A726D0D4039C3D140AE6190B1145513",
  "dividend" => nil,
  "identities" => [],
  "joiners" => [],
  "actives" => [],
  "leavers" => [],
  "revoked" => [],
  "excluded" => [],
  "certifications" => [],
  "transactions" => [
  %{"version" => 10,
   "currency" => "g1",
   "locktime" => 0,
   "hash" => "4CDFE3315CE4ED198CBB7867DEDDAE15250DD8F094555778E9A1CC1545047A84",
   "blockstamp" => "98-000008CD42C3D493BED61C52482BCB3288DAF9A5F6FD253C07979716D0B7EFAC",
   "blockstampTime" => 1488998917,
   "issuers" => ["D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx", "E0DE3azJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx"],
   "inputs" => ["1000:0:D:D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx:1"],
   "outputs" => ["500:0:SIG(2ny7YAdmzReQxAayyJZsyVYwYhVyax2thKcGknmQy5nQ)",
   "500:0:SIG(D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx)"],
   "unlocks" => ["0:SIG(0)"],
   "signatures" => ["CvfE2MawgbsHC6FM8IDEWZG7t55RDlaPpff7DdipGJ0mjFwC1s/+S3H7UURZ6wcEgndXQt/fZTx1wQz9A1zaDA=="],
   "comment" => "Merci pour toutes ces annees de dev pour les monnaies libres"
  }
  ],
  "raw" => "Version: 10\nType: Block\nCurrency: g1\nNumber: 100\nPoWMin: 78\nTime: 1489003535\nMedianTime: 1488999490\nUnitBase: 0\nIssuer: Be1eVp7etVfA7cT6er6dcJ9d5KxGJVY2tzCGGCAz3yG\nIssuersFrame: 41\nIssuersFrameVar: 10\nDifferentIssuersCount: 10\nPreviousHash: 000012AD496ECA56DE0B8E5D6F749B7CBE78553E6385333A44E04377EFFCCA53\nPreviousIssuer: GfKERHnJTYzKhKUma5h1uWhetbA8yHKymhVH2raf2aCP\nMembersCount: 59\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nTX:10:1:1:1:2:1:0\n98-000008CD42C3D493BED61C52482BCB3288DAF9A5F6FD253C07979716D0B7EFAC\nD9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx\n1000:0:D:D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx:1\n0:SIG(0)\n500:0:SIG(2ny7YAdmzReQxAayyJZsyVYwYhVyax2thKcGknmQy5nQ)\n500:0:SIG(D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx)\nMerci pour toutes ces annees de dev pour les monnaies libres\nCvfE2MawgbsHC6FM8IDEWZG7t55RDlaPpff7DdipGJ0mjFwC1s/+S3H7UURZ6wcEgndXQt/fZTx1wQz9A1zaDA==\nInnerHash: A43FDA346B087982647C6F85851B2CAC6A726D0D4039C3D140AE6190B1145513\nNonce: 10300000071384\n"
  }

  @block_one_tx_no_issuers %{"version" => 10,
  "nonce" => 10300000071384,
  "number" => 100,
  "powMin" => 78,
  "time" => 1489003535,
  "medianTime" => 1488999490,
  "membersCount" => 59,
  "monetaryMass" => 59000,
  "unitbase" => 0,
  "issuersCount" => 10,
  "issuersFrame" => 41,
  "issuersFrameVar" => 10,
  "currency" => "g1",
  "issuer" => "Be1eVp7etVfA7cT6er6dcJ9d5KxGJVY2tzCGGCAz3yG",
  "signature" => "2/1Qk5ekJL9BUMnW2j6AMR0wGuGgBkU4UWGumKYOyy/k7c5ZqhskLhsERWf47wocjyL9QBvQDDy3S8P9dXA5CA==",
  "hash" => "00000E2C80F67FDCF0A0BA975FF7A7025FDA3B51EE1365CFABC468EAC070D5AD",
  "parameters" => "",
  "previousHash" => "000012AD496ECA56DE0B8E5D6F749B7CBE78553E6385333A44E04377EFFCCA53",
  "previousIssuer" => "GfKERHnJTYzKhKUma5h1uWhetbA8yHKymhVH2raf2aCP",
  "inner_hash" => "A43FDA346B087982647C6F85851B2CAC6A726D0D4039C3D140AE6190B1145513",
  "dividend" => nil,
  "identities" => [],
  "joiners" => [],
  "actives" => [],
  "leavers" => [],
  "revoked" => [],
  "excluded" => [],
  "certifications" => [],
  "transactions" => [
  %{"version" => 10,
   "currency" => "g1",
   "locktime" => 0,
   "hash" => "4CDFE3315CE4ED198CBB7867DEDDAE15250DD8F094555778E9A1CC1545047A84",
   "blockstamp" => "98-000008CD42C3D493BED61C52482BCB3288DAF9A5F6FD253C07979716D0B7EFAC",
   "blockstampTime" => 1488998917,
   "issuers" => [],
   "inputs" => ["1000:0:D:D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx:1"],
   "outputs" => ["500:0:SIG(2ny7YAdmzReQxAayyJZsyVYwYhVyax2thKcGknmQy5nQ)",
   "500:0:SIG(D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx)"],
   "unlocks" => ["0:SIG(0)"],
   "signatures" => ["CvfE2MawgbsHC6FM8IDEWZG7t55RDlaPpff7DdipGJ0mjFwC1s/+S3H7UURZ6wcEgndXQt/fZTx1wQz9A1zaDA=="],
   "comment" => "Merci pour toutes ces annees de dev pour les monnaies libres"
  }
  ],
  "raw" => "Version: 10\nType: Block\nCurrency: g1\nNumber: 100\nPoWMin: 78\nTime: 1489003535\nMedianTime: 1488999490\nUnitBase: 0\nIssuer: Be1eVp7etVfA7cT6er6dcJ9d5KxGJVY2tzCGGCAz3yG\nIssuersFrame: 41\nIssuersFrameVar: 10\nDifferentIssuersCount: 10\nPreviousHash: 000012AD496ECA56DE0B8E5D6F749B7CBE78553E6385333A44E04377EFFCCA53\nPreviousIssuer: GfKERHnJTYzKhKUma5h1uWhetbA8yHKymhVH2raf2aCP\nMembersCount: 59\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nTX:10:1:1:1:2:1:0\n98-000008CD42C3D493BED61C52482BCB3288DAF9A5F6FD253C07979716D0B7EFAC\nD9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx\n1000:0:D:D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx:1\n0:SIG(0)\n500:0:SIG(2ny7YAdmzReQxAayyJZsyVYwYhVyax2thKcGknmQy5nQ)\n500:0:SIG(D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx)\nMerci pour toutes ces annees de dev pour les monnaies libres\nCvfE2MawgbsHC6FM8IDEWZG7t55RDlaPpff7DdipGJ0mjFwC1s/+S3H7UURZ6wcEgndXQt/fZTx1wQz9A1zaDA==\nInnerHash: A43FDA346B087982647C6F85851B2CAC6A726D0D4039C3D140AE6190B1145513\nNonce: 10300000071384\n"
  }

  @block_two_tx_ok %{ "version" => 10,
  "nonce" => 10400000021742,
  "number" => 101692,
  "powMin" => 87,
  "time" => 1520711224,
  "medianTime" => 1520706991,
  "membersCount" => 797,
  "monetaryMass" => 121018918,
  "unitbase" => 0,
  "issuersCount" => 34,
  "issuersFrame" => 171,
  "issuersFrameVar" => 0,
  "currency" => "g1",
  "issuer" => "5kpscasQx9p45TXJxtGV17G1Fw9URmMeqouz3x8FNYpB",
  "signature" => "g3R3N16AQ5X08BlGRy435rHEXR588MnoAVbOLjNmqqXEGyHohrSizeQFwIZPBQvzFlXrLcyqFqUw/EexSEQYAA==",
  "hash" => "0000083D2DE954FB042972B5A3A0142B9B72ABC34545F13847F5B6559B3549FE",
  "parameters" => "",
  "previousHash" => "00000400E8E0DE1BA3D0563C79C87B3C6568A3DCFC15C1D9C328D9893622E998",
  "previousIssuer" => "98wvdsHGnnNDczKMp6FM9KUuPRBTwn77PN4x6EC6i9KN",
  "inner_hash" => "1846CFD477794CDB08C72EF35EDBBE0EEE1B22DBC2DB06F331CE298A380BDA94",
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
  "currency" => "g1",
  "comment" => "",
  "locktime" => 0,
  "signatures" => [
  "lCbG4kU9+dqOWDLAjAL2t0Bfb1Vc6DJjjGIJ0GUFyRzed+enlKZjOOV5tvWMQMhKpdB6MeraZEuGcEGOH6BrAQ=="
  ],
  "outputs" => [
  "2000:0:SIG(6dMVyFtMWYrtHhcqs2YUqMzQW9S6A6q6emXdf7LdP2Es)",
  "4000:0:SIG(C3ivNUep9gvKjoheCE8DoeL4LsJjT4W2VXLuBKNFCkGV)"
  ],
  "inputs" => [
  "1000:0:T:0DFB1C5B44FCFBD3ED7CCDC8D23BB8814C0FBE269144B0E562CF491E7422E651:0",
  "5000:0:T:4D6CE5099923E619133D0F1B9212998BC443D639BEFB1BB53AB2901D5A3DE88C:0"
  ],
  "unlocks" => [
  "0:SIG(0)",
  "1:SIG(0)"
  ],
  "blockstamp" => "101690-000001B3987BEEFC02F1FC250940A8633C31427B51085A7318888E378958907B",
  "blockstampTime" => 0,
  "issuers" => [
  "C3ivNUep9gvKjoheCE8DoeL4LsJjT4W2VXLuBKNFCkGV"
  ],
  "block_number" => 0,
  "time" => 0
  },
  %{
  "version" => 10,
  "currency" => "g1",
  "comment" => "Merci pour le badge",
  "locktime" => 0,
  "signatures" => [
  "HDhswLmgc895FfRBy25NtJtINK+bLlYYtKReJi5T7Ntf48hDIgVWUDg9ur74a6jiQfQsiLIq3g3ux2oU63PXDw=="
  ],
  "outputs" => [
  "1000:0:SIG(6dMVyFtMWYrtHhcqs2YUqMzQW9S6A6q6emXdf7LdP2Es)",
  "1:0:SIG(A6Xg3JmPkhTgz8LTq16ohvJzwePaRMstcePgwt6gcKf9)"
  ],
  "inputs" => [
  "1001:0:D:A6Xg3JmPkhTgz8LTq16ohvJzwePaRMstcePgwt6gcKf9:65439"
  ],
  "unlocks" => [
  "0:SIG(0)"
  ],
  "blockstamp" => "101690-000001B3987BEEFC02F1FC250940A8633C31427B51085A7318888E378958907B",
  "blockstampTime" => 0,
  "issuers" => [
  "A6Xg3JmPkhTgz8LTq16ohvJzwePaRMstcePgwt6gcKf9"
  ],
  "block_number" => 0,
  "time" => 0
  }
  ],
  "raw" => "Version: 10\nType: Block\nCurrency: g1\nNumber: 101692\nPoWMin: 87\nTime: 1520711224\nMedianTime: 1520706991\nUnitBase: 0\nIssuer:   5kpscasQx9p45TXJxtGV17G1Fw9URmMeqouz3x8FNYpB\nIssuersFrame: 171\nIssuersFrameVar: 0\nDifferentIssuersCount: 34\nPreviousHash:   		      00000400E8E0DE1BA3D0563C79C87B3C6568A3DCFC15C1D9C328D9893622E998\nPreviousIssuer: 98wvdsHGnnNDczKMp6FM9KUuPRBTwn77PN4x6EC6i9KN\nMembersCount: 797\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nTX:10:1:2:2:2:0:0\n101690-000001B3987BEEFC02F1FC250940A8633C31427B51085A7318888E378958907B\nC3ivNUep9gvKjoheCE8DoeL4LsJjT4W2VXLuBKNFCkGV\n1000:0:T:0DFB1C5B44FCFBD3ED7CCDC8D23BB8814C0FBE269144B0E562CF491E7422E651:0\n5000:0:T:4D6CE5099923E619133D0F1B9212998BC443D639BEFB1BB53AB2901D5A3DE88C:0\n0:SIG(0)\n1:SIG(0)\n2000:0:SIG(6dMVyFtMWYrtHhcqs2YUqMzQW9S6A6q6emXdf7LdP2Es)\n4000:0:SIG(C3ivNUep9gvKjoheCE8DoeL4LsJjT4W2VXLuBKNFCkGV)\nlCbG4kU9+dqOWDLAjAL2t0Bfb1Vc6DJjjGIJ0GUFyRzed+enlKZjOOV5tvWMQMhKpdB6MeraZEuGcEGOH6BrAQ==\nTX:10:1:1:1:2:1:0\n101690-000001B3987BEEFC02F1FC250940A8633C31427B51085A7318888E378958907B\nA6Xg3JmPkhTgz8LTq16ohvJzwePaRMstcePgwt6gcKf9\n1001:0:D:A6Xg3JmPkhTgz8LTq16ohvJzwePaRMstcePgwt6gcKf9:65439\n0:SIG(0)\n1000:0:SIG(6dMVyFtMWYrtHhcqs2YUqMzQW9S6A6q6emXdf7LdP2Es)\n1:0:SIG(A6Xg3JmPkhTgz8LTq16ohvJzwePaRMstcePgwt6gcKf9)\nMerci pour le badge\nHDhswLmgc895FfRBy25NtJtINK+bLlYYtKReJi5T7Ntf48hDIgVWUDg9ur74a6jiQfQsiLIq3g3ux2oU63PXDw==\nInnerHash: 1846CFD477794CDB08C72EF35EDBBE0EEE1B22DBC2DB06F331CE298A380BDA94\nNonce: 10400000021742\n"
  }

  @block_one_tx_ok_one_tx_nok %{ "version" => 10,
  "nonce" => 10400000021742,
  "number" => 101692,
  "powMin" => 87,
  "time" => 1520711224,
  "medianTime" => 1520706991,
  "membersCount" => 797,
  "monetaryMass" => 121018918,
  "unitbase" => 0,
  "issuersCount" => 34,
  "issuersFrame" => 171,
  "issuersFrameVar" => 0,
  "currency" => "g1",
  "issuer" => "5kpscasQx9p45TXJxtGV17G1Fw9URmMeqouz3x8FNYpB",
  "signature" => "g3R3N16AQ5X08BlGRy435rHEXR588MnoAVbOLjNmqqXEGyHohrSizeQFwIZPBQvzFlXrLcyqFqUw/EexSEQYAA==",
  "hash" => "0000083D2DE954FB042972B5A3A0142B9B72ABC34545F13847F5B6559B3549FE",
  "parameters" => "",
  "previousHash" => "00000400E8E0DE1BA3D0563C79C87B3C6568A3DCFC15C1D9C328D9893622E998",
  "previousIssuer" => "98wvdsHGnnNDczKMp6FM9KUuPRBTwn77PN4x6EC6i9KN",
  "inner_hash" => "1846CFD477794CDB08C72EF35EDBBE0EEE1B22DBC2DB06F331CE298A380BDA94",
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
  "currency" => "g1",
  "comment" => "",
  "locktime" => 0,
  "signatures" => [
  "lCbG4kU9+dqOWDLAjAL2t0Bfb1Vc6DJjjGIJ0GUFyRzed+enlKZjOOV5tvWMQMhKpdB6MeraZEuGcEGOH6BrAQ=="
  ],
  "outputs" => [
  "2000:0:SIG(6dMVyFtMWYrtHhcqs2YUqMzQW9S6A6q6emXdf7LdP2Es)",
  "4000:0:SIG(C3ivNUep9gvKjoheCE8DoeL4LsJjT4W2VXLuBKNFCkGV)"
  ],
  "inputs" => [
  "1000:0:T:0DFB1C5B44FCFBD3ED7CCDC8D23BB8814C0FBE269144B0E562CF491E7422E651:0",
  "5000:0:T:4D6CE5099923E619133D0F1B9212998BC443D639BEFB1BB53AB2901D5A3DE88C:0"
  ],
  "unlocks" => [
  "0:SIG(0)",
  "1:SIG(42)"
  ],
  "blockstamp" => "101690-000001B3987BEEFC02F1FC250940A8633C31427B51085A7318888E378958907B",
  "blockstampTime" => 0,
  "issuers" => [
  "C3ivNUep9gvKjoheCE8DoeL4LsJjT4W2VXLuBKNFCkGV"
  ],
  "block_number" => 0,
  "time" => 0
  },
  %{
  "version" => 10,
  "currency" => "g1",
  "comment" => "Merci pour le badge",
  "locktime" => 0,
  "signatures" => [
  "HDhswLmgc895FfRBy25NtJtINK+bLlYYtKReJi5T7Ntf48hDIgVWUDg9ur74a6jiQfQsiLIq3g3ux2oU63PXDw=="
  ],
  "outputs" => [
  "1000:0:SIG(6dMVyFtMWYrtHhcqs2YUqMzQW9S6A6q6emXdf7LdP2Es)",
  "1:0:SIG(A6Xg3JmPkhTgz8LTq16ohvJzwePaRMstcePgwt6gcKf9)"
  ],
  "inputs" => [
  "1001:0:D:A6Xg3JmPkhTgz8LTq16ohvJzwePaRMstcePgwt6gcKf9:65439"
  ],
  "unlocks" => [
  "0:SIG(0)"
  ],
  "blockstamp" => "101690-000001B3987BEEFC02F1FC250940A8633C31427B51085A7318888E378958907B",
  "blockstampTime" => 0,
  "issuers" => [
  "A6Xg3JmPkhTgz8LTq16ohvJzwePaRMstcePgwt6gcKf9"
  ],
  "block_number" => 0,
  "time" => 0
  }
  ],
  "raw" => "Version: 10\nType: Block\nCurrency: g1\nNumber: 101692\nPoWMin: 87\nTime: 1520711224\nMedianTime: 1520706991\nUnitBase: 0\nIssuer:   5kpscasQx9p45TXJxtGV17G1Fw9URmMeqouz3x8FNYpB\nIssuersFrame: 171\nIssuersFrameVar: 0\nDifferentIssuersCount: 34\nPreviousHash:   		      00000400E8E0DE1BA3D0563C79C87B3C6568A3DCFC15C1D9C328D9893622E998\nPreviousIssuer: 98wvdsHGnnNDczKMp6FM9KUuPRBTwn77PN4x6EC6i9KN\nMembersCount: 797\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nTX:10:1:2:2:2:0:0\n101690-000001B3987BEEFC02F1FC250940A8633C31427B51085A7318888E378958907B\nC3ivNUep9gvKjoheCE8DoeL4LsJjT4W2VXLuBKNFCkGV\n1000:0:T:0DFB1C5B44FCFBD3ED7CCDC8D23BB8814C0FBE269144B0E562CF491E7422E651:0\n5000:0:T:4D6CE5099923E619133D0F1B9212998BC443D639BEFB1BB53AB2901D5A3DE88C:0\n0:SIG(0)\n1:SIG(0)\n2000:0:SIG(6dMVyFtMWYrtHhcqs2YUqMzQW9S6A6q6emXdf7LdP2Es)\n4000:0:SIG(C3ivNUep9gvKjoheCE8DoeL4LsJjT4W2VXLuBKNFCkGV)\nlCbG4kU9+dqOWDLAjAL2t0Bfb1Vc6DJjjGIJ0GUFyRzed+enlKZjOOV5tvWMQMhKpdB6MeraZEuGcEGOH6BrAQ==\nTX:10:1:1:1:2:1:0\n101690-000001B3987BEEFC02F1FC250940A8633C31427B51085A7318888E378958907B\nA6Xg3JmPkhTgz8LTq16ohvJzwePaRMstcePgwt6gcKf9\n1001:0:D:A6Xg3JmPkhTgz8LTq16ohvJzwePaRMstcePgwt6gcKf9:65439\n0:SIG(0)\n1000:0:SIG(6dMVyFtMWYrtHhcqs2YUqMzQW9S6A6q6emXdf7LdP2Es)\n1:0:SIG(A6Xg3JmPkhTgz8LTq16ohvJzwePaRMstcePgwt6gcKf9)\nMerci pour le badge\nHDhswLmgc895FfRBy25NtJtINK+bLlYYtKReJi5T7Ntf48hDIgVWUDg9ur74a6jiQfQsiLIq3g3ux2oU63PXDw==\nInnerHash: 1846CFD477794CDB08C72EF35EDBBE0EEE1B22DBC2DB06F331CE298A380BDA94\nNonce: 10400000021742\n"
  }



  test "validates the transactions don't have too few issuers" do
  assert TxInfNbIssuers.valid(@block_no_tx)
  assert TxInfNbIssuers.valid(@block_one_tx_one_issuer)
  assert TxInfNbIssuers.valid(@block_one_tx_many_issuers)
  refute TxInfNbIssuers.valid(@block_one_tx_no_issuers)
  refute TxInfNbIssuers.valid(@block_one_tx_ok_one_tx_nok)
  assert TxInfNbIssuers.valid(@block_two_tx_ok)
  end

end
