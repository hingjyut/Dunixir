defmodule Block.Validation.Local.TxSigOrderedTest do
  use ExUnit.Case
  doctest Block.Validation.Local.TxSigOrdered

  alias Block.Validation.Local.TxSigOrdered, as: TxSigOrdered

  @one_issuer_correct %{
    "version" => 10,
    "nonce" => 10_700_000_025_540,
    "number" => 100_003,
    "powMin" => 85,
    "time" => 1_520_199_092,
    "medianTime" => 1_520_196_079,
    "membersCount" => 778,
    "monetaryMass" => 116_290_194,
    "unitbase" => 0,
    "issuersCount" => 33,
    "issuersFrame" => 164,
    "issuersFrameVar" => 2,
    "currency" => "g1",
    "issuer" => "DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ",
    "signature" =>
      "2AxFJcjoayRcbWicD+8i1jJg49xhhnTCm1yVAYEH5xCCsQ4YCYXwN3fM8vSn7Iaha/3qj1iRVTH8oqz6E+AQDg==",
    "hash" => "0000023847D63D9E707053A7B4F2DB53902FB0765D4DE604294146FC2412941D",
    "parameters" => "",
    "previousHash" => "0000068D8D2ABEB0A4E7C5B87AD7E108B27CF1DBF7A1CFED04AB700FB3CF36B5",
    "previousIssuer" => "4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m",
    "inner_hash" => "D6617F43EC29E34B71AB9ADFFAA929E59C2FA3D3BF58F2E26B5D8DBB4271009B",
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
        "locktime" => 0,
        "hash" => "676D38DA93A4071729CFB85B077C8D753037C822A7A842354DD554873A42D7D4",
        "blockstamp" => "100001-00000273D97983AA983A5E179AC5F02B40A2E9AE2BA45C980EDC35D885FC4AFF",
        "blockstampTime" => 0,
        "issuers" => [
          "TENGx7WtzFsTXwnbrPEvb6odX2WnqYcnnrjiiLvp1mS"
        ],
        "inputs" => [
          "220100:0:T:B708270B661161DA6A8CF68B7B80895864CAA991F9CABD8D4A06D68CAE7C1DBE:33",
          "10000:0:T:FDB0C5E8318D4253205BB75FDFAEF259A802124FEC1AD3794D525F7951D85658:0",
          "20020:0:T:EC09188639DC8125FB30B2B8B9BE733F8AE267CA6AEE5466075B940B64E59592:0"
        ],
        "outputs" => [
          "90:0:SIG(2ZPiZZLKsUitStqyv28e4cipchxDQiPZxEYNN6xmqxJx)",
          "135:0:SIG(98wvdsHGnnNDczKMp6FM9KUuPRBTwn77PN4x6EC6i9KN)",
          "105:0:SIG(FVUFRrk1K5TQGsY7PRLwqHgdHRoHrwb1hcucp4C2N5tD)",
          "190:0:SIG(GRBPV3Y7PQnB9LaZhSGuS3BqBJbSHyibzYq65kTh1nQ4)",
          "120:0:SIG(6fFt4zdvtNyVcfJn7Y41mKLmMDizyK3nVeNW3qdDXzpc)",
          "155:0:SIG(DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ)",
          "130:0:SIG(4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m)",
          "160:0:SIG(D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx)",
          "155:0:SIG(38MEAZN68Pz1DTvT3tqgxx4yQP6snJCQhPqEFxbDk4aE)",
          "105:0:SIG(CV1GNhPpVisWZMe3THGnGLca5KkyfbTra5UgkFgKUJTm)",
          "85:0:SIG(FSAPnBZidfUaiURd1qxwmx4z5VGEPvYfthWfq5vfwGFB)",
          "80:0:SIG(4GX5gUFwKg8Y8oL5ZFwFD64U3vEJo6CtY61Y3J8LMCHk)",
          "70:0:SIG(CRBxCJrTA6tmHsgt9cQh9SHcCc8w8q95YTp38CPHx2Uk)",
          "15:0:SIG(3wdDzBz18mWupx1UChMnhky2Nut3XVnyn9U7Y662J7yE)",
          "85:0:SIG(81t4UcqmrVnRqGaQwc2zSmoe1bM5G4vQ7fPxbTeD8a5X)",
          "45:0:SIG(7AQzQb475tEzCkSLKD4HffeQbckizJWFvubhYA2rfwgt)",
          "100:0:SIG(GfKERHnJTYzKhKUma5h1uWhetbA8yHKymhVH2raf2aCP)",
          "60:0:SIG(5kpscasQx9p45TXJxtGV17G1Fw9URmMeqouz3x8FNYpB)",
          "25:0:SIG(6FqjGokAhv6rfXZSmiZs4u9CBJqTFtLZNQXE7Qw2RTNZ)",
          "85:0:SIG(2ny7YAdmzReQxAayyJZsyVYwYhVyax2thKcGknmQy5nQ)",
          "20:0:SIG(5cnvo5bmR8QbtyNVnkDXWq6n5My6oNLd1o6auJApGCsv)",
          "35:0:SIG(HbTqJ1Ts3RhJ8Rx4XkNyh1oSKmoZL1kY5U7t9mKTSjAB)",
          "95:0:SIG(2sZF6j2PkxBDNAqUde7Dgo5x3crkerZpQ4rBqqJGn8QT)",
          "10:0:SIG(4bD7J3uA5pH2N9Xqimspf2XxWN4ESM2Az2XBqtSeHvUZ)",
          "60:0:SIG(5gJYnQp8v7bWwk7EWRoL8vCLof1r3y9c6VDdnGSM1GLv)",
          "30:0:SIG(Hxvt6Yj6n7sYud5YCiH6z4NJT4mbuSjBqErVX4V8GE3)",
          "45:0:SIG(AmDcZSEB5MCt8GyZ1VMRt1sUwRH5D7HpXx8YKhMKZ1qa)",
          "15:0:SIG(7G2mS5aCoT4jCL5WfLKQsXfMJaV9d3jVGUGnwq6Tg36J)",
          "40:0:SIG(7vU9BMDhN6fBuRa2iK3JRbC6pqQKb4qDMGsFcQuT5cz)",
          "15:0:SIG(Be1eVp7etVfA7cT6er6dcJ9d5KxGJVY2tzCGGCAz3yG)",
          "50:0:SIG(5dzkzedBWdeqTFCaD7AkKPMPusfRUL1XyFNJWWGYQ9f1)",
          "15:0:SIG(D3krfq6J9AmfpKnS3gQVYoy7NzGCc61vokteTS8LJ4YH)",
          "5:0:SIG(92VdBcvvCWVBc79kNHpqLceiyPuCxrCwNx1zLacsVy2L)",
          "30:0:SIG(9zCYjVtPFzqjuQ3d1vY1FuHhpEuRpafXkiEpwE3RypN1)",
          "5:0:SIG(FEkbc4BfJukSWnCU6Hed6dgwwTuPFTVdgz5LpL4iHr9J)",
          "10:0:SIG(9toSKwQayx462ye94gtJ4JJh69k2KAWfmzjK6kNZBLph)",
          "20:0:SIG(EwXXo4YAG6BuNhifNZrMKAXNDXcYDhFWaZcSu5iZnSUX)",
          "5:0:SIG(9UuWHs3ZDvV4EiViDGf2zJKNUa8V2ot7hH2zPD1C1sj1)",
          "247620:0:SIG(TENGx7WtzFsTXwnbrPEvb6odX2WnqYcnnrjiiLvp1mS)"
        ],
        "unlocks" => [
          "0:SIG(0)",
          "1:SIG(0)",
          "2:SIG(0)"
        ],
        "signatures" => [
          "nnQLYOsiXa9fqy7dHTm1gA+Wwru3MJl6nSBrUWBOlSS9RLg3rTFYA42ClTNXt55QJKr7cUP9caZeJRl8BHAoAQ=="
        ],
        "comment" => "REMU:99501:100000"
      }
    ],
    "raw" =>
      "Version: 10\nType: Block\nCurrency: g1\nNumber: 100003\nPoWMin: 85\nTime: 1520199092\nMedianTime: 1520196079\nUnitBase: 0\nIssuer: DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ\nIssuersFrame: 164\nIssuersFrameVar: 2\nDifferentIssuersCount: 33\nPreviousHash: 0000068D8D2ABEB0A4E7C5B87AD7E108B27CF1DBF7A1CFED04AB700FB3CF36B5\nPreviousIssuer: 4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m\nMembersCount: 778\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nTX:10:1:3:3:39:1:0\n100001-00000273D97983AA983A5E179AC5F02B40A2E9AE2BA45C980EDC35D885FC4AFF\nTENGx7WtzFsTXwnbrPEvb6odX2WnqYcnnrjiiLvp1mS\n220100:0:T:B708270B661161DA6A8CF68B7B80895864CAA991F9CABD8D4A06D68CAE7C1DBE:33\n10000:0:T:FDB0C5E8318D4253205BB75FDFAEF259A802124FEC1AD3794D525F7951D85658:0\n20020:0:T:EC09188639DC8125FB30B2B8B9BE733F8AE267CA6AEE5466075B940B64E59592:0\n0:SIG(0)\n1:SIG(0)\n2:SIG(0)\n90:0:SIG(2ZPiZZLKsUitStqyv28e4cipchxDQiPZxEYNN6xmqxJx)\n135:0:SIG(98wvdsHGnnNDczKMp6FM9KUuPRBTwn77PN4x6EC6i9KN)\n105:0:SIG(FVUFRrk1K5TQGsY7PRLwqHgdHRoHrwb1hcucp4C2N5tD)\n190:0:SIG(GRBPV3Y7PQnB9LaZhSGuS3BqBJbSHyibzYq65kTh1nQ4)\n120:0:SIG(6fFt4zdvtNyVcfJn7Y41mKLmMDizyK3nVeNW3qdDXzpc)\n155:0:SIG(DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ)\n130:0:SIG(4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m)\n160:0:SIG(D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx)\n155:0:SIG(38MEAZN68Pz1DTvT3tqgxx4yQP6snJCQhPqEFxbDk4aE)\n105:0:SIG(CV1GNhPpVisWZMe3THGnGLca5KkyfbTra5UgkFgKUJTm)\n85:0:SIG(FSAPnBZidfUaiURd1qxwmx4z5VGEPvYfthWfq5vfwGFB)\n80:0:SIG(4GX5gUFwKg8Y8oL5ZFwFD64U3vEJo6CtY61Y3J8LMCHk)\n70:0:SIG(CRBxCJrTA6tmHsgt9cQh9SHcCc8w8q95YTp38CPHx2Uk)\n15:0:SIG(3wdDzBz18mWupx1UChMnhky2Nut3XVnyn9U7Y662J7yE)\n85:0:SIG(81t4UcqmrVnRqGaQwc2zSmoe1bM5G4vQ7fPxbTeD8a5X)\n45:0:SIG(7AQzQb475tEzCkSLKD4HffeQbckizJWFvubhYA2rfwgt)\n100:0:SIG(GfKERHnJTYzKhKUma5h1uWhetbA8yHKymhVH2raf2aCP)\n60:0:SIG(5kpscasQx9p45TXJxtGV17G1Fw9URmMeqouz3x8FNYpB)\n25:0:SIG(6FqjGokAhv6rfXZSmiZs4u9CBJqTFtLZNQXE7Qw2RTNZ)\n85:0:SIG(2ny7YAdmzReQxAayyJZsyVYwYhVyax2thKcGknmQy5nQ)\n20:0:SIG(5cnvo5bmR8QbtyNVnkDXWq6n5My6oNLd1o6auJApGCsv)\n35:0:SIG(HbTqJ1Ts3RhJ8Rx4XkNyh1oSKmoZL1kY5U7t9mKTSjAB)\n95:0:SIG(2sZF6j2PkxBDNAqUde7Dgo5x3crkerZpQ4rBqqJGn8QT)\n10:0:SIG(4bD7J3uA5pH2N9Xqimspf2XxWN4ESM2Az2XBqtSeHvUZ)\n60:0:SIG(5gJYnQp8v7bWwk7EWRoL8vCLof1r3y9c6VDdnGSM1GLv)\n30:0:SIG(Hxvt6Yj6n7sYud5YCiH6z4NJT4mbuSjBqErVX4V8GE3)\n45:0:SIG(AmDcZSEB5MCt8GyZ1VMRt1sUwRH5D7HpXx8YKhMKZ1qa)\n15:0:SIG(7G2mS5aCoT4jCL5WfLKQsXfMJaV9d3jVGUGnwq6Tg36J)\n40:0:SIG(7vU9BMDhN6fBuRa2iK3JRbC6pqQKb4qDMGsFcQuT5cz)\n15:0:SIG(Be1eVp7etVfA7cT6er6dcJ9d5KxGJVY2tzCGGCAz3yG)\n50:0:SIG(5dzkzedBWdeqTFCaD7AkKPMPusfRUL1XyFNJWWGYQ9f1)\n15:0:SIG(D3krfq6J9AmfpKnS3gQVYoy7NzGCc61vokteTS8LJ4YH)\n5:0:SIG(92VdBcvvCWVBc79kNHpqLceiyPuCxrCwNx1zLacsVy2L)\n30:0:SIG(9zCYjVtPFzqjuQ3d1vY1FuHhpEuRpafXkiEpwE3RypN1)\n5:0:SIG(FEkbc4BfJukSWnCU6Hed6dgwwTuPFTVdgz5LpL4iHr9J)\n10:0:SIG(9toSKwQayx462ye94gtJ4JJh69k2KAWfmzjK6kNZBLph)\n20:0:SIG(EwXXo4YAG6BuNhifNZrMKAXNDXcYDhFWaZcSu5iZnSUX)\n5:0:SIG(9UuWHs3ZDvV4EiViDGf2zJKNUa8V2ot7hH2zPD1C1sj1)\n247620:0:SIG(TENGx7WtzFsTXwnbrPEvb6odX2WnqYcnnrjiiLvp1mS)\nREMU:99501:100000\nnnQLYOsiXa9fqy7dHTm1gA+Wwru3MJl6nSBrUWBOlSS9RLg3rTFYA42ClTNXt55QJKr7cUP9caZeJRl8BHAoAQ==\nInnerHash: D6617F43EC29E34B71AB9ADFFAA929E59C2FA3D3BF58F2E26B5D8DBB4271009B\nNonce: 10700000025540\n"
  }

  @one_issuer_bad_sig %{
    "version" => 10,
    "nonce" => 10_700_000_025_540,
    "number" => 100_003,
    "powMin" => 85,
    "time" => 1_520_199_092,
    "medianTime" => 1_520_196_079,
    "membersCount" => 778,
    "monetaryMass" => 116_290_194,
    "unitbase" => 0,
    "issuersCount" => 33,
    "issuersFrame" => 164,
    "issuersFrameVar" => 2,
    "currency" => "g1",
    "issuer" => "DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ",
    "signature" =>
      "2AxFJcjoayRcbWicD+8i1jJg49xhhnTCm1yVAYEH5xCCsQ4YCYXwN3fM8vSn7Iaha/3qj1iRVTH8oqz6E+AQDg==",
    "hash" => "0000023847D63D9E707053A7B4F2DB53902FB0765D4DE604294146FC2412941D",
    "parameters" => "",
    "previousHash" => "0000068D8D2ABEB0A4E7C5B87AD7E108B27CF1DBF7A1CFED04AB700FB3CF36B5",
    "previousIssuer" => "4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m",
    "inner_hash" => "D6617F43EC29E34B71AB9ADFFAA929E59C2FA3D3BF58F2E26B5D8DBB4271009B",
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
        "locktime" => 0,
        "hash" => "676D38DA93A4071729CFB85B077C8D753037C822A7A842354DD554873A42D7D4",
        "blockstamp" => "100001-00000273D97983AA983A5E179AC5F02B40A2E9AE2BA45C980EDC35D885FC4AFF",
        "blockstampTime" => 0,
        "issuers" => [
          "TENGx7WtzFsTXwnbrPEvb6odX2WnqYcnnrjiiLvp1mS"
        ],
        "inputs" => [
          "220100:0:T:B708270B661161DA6A8CF68B7B80895864CAA991F9CABD8D4A06D68CAE7C1DBE:33",
          "10000:0:T:FDB0C5E8318D4253205BB75FDFAEF259A802124FEC1AD3794D525F7951D85658:0",
          "20020:0:T:EC09188639DC8125FB30B2B8B9BE733F8AE267CA6AEE5466075B940B64E59592:0"
        ],
        "outputs" => [
          "90:0:SIG(2ZPiZZLKsUitStqyv28e4cipchxDQiPZxEYNN6xmqxJx)",
          "135:0:SIG(98wvdsHGnnNDczKMp6FM9KUuPRBTwn77PN4x6EC6i9KN)",
          "105:0:SIG(FVUFRrk1K5TQGsY7PRLwqHgdHRoHrwb1hcucp4C2N5tD)",
          "190:0:SIG(GRBPV3Y7PQnB9LaZhSGuS3BqBJbSHyibzYq65kTh1nQ4)",
          "120:0:SIG(6fFt4zdvtNyVcfJn7Y41mKLmMDizyK3nVeNW3qdDXzpc)",
          "155:0:SIG(DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ)",
          "130:0:SIG(4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m)",
          "160:0:SIG(D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx)",
          "155:0:SIG(38MEAZN68Pz1DTvT3tqgxx4yQP6snJCQhPqEFxbDk4aE)",
          "105:0:SIG(CV1GNhPpVisWZMe3THGnGLca5KkyfbTra5UgkFgKUJTm)",
          "85:0:SIG(FSAPnBZidfUaiURd1qxwmx4z5VGEPvYfthWfq5vfwGFB)",
          "80:0:SIG(4GX5gUFwKg8Y8oL5ZFwFD64U3vEJo6CtY61Y3J8LMCHk)",
          "70:0:SIG(CRBxCJrTA6tmHsgt9cQh9SHcCc8w8q95YTp38CPHx2Uk)",
          "15:0:SIG(3wdDzBz18mWupx1UChMnhky2Nut3XVnyn9U7Y662J7yE)",
          "85:0:SIG(81t4UcqmrVnRqGaQwc2zSmoe1bM5G4vQ7fPxbTeD8a5X)",
          "45:0:SIG(7AQzQb475tEzCkSLKD4HffeQbckizJWFvubhYA2rfwgt)",
          "100:0:SIG(GfKERHnJTYzKhKUma5h1uWhetbA8yHKymhVH2raf2aCP)",
          "60:0:SIG(5kpscasQx9p45TXJxtGV17G1Fw9URmMeqouz3x8FNYpB)",
          "25:0:SIG(6FqjGokAhv6rfXZSmiZs4u9CBJqTFtLZNQXE7Qw2RTNZ)",
          "85:0:SIG(2ny7YAdmzReQxAayyJZsyVYwYhVyax2thKcGknmQy5nQ)",
          "20:0:SIG(5cnvo5bmR8QbtyNVnkDXWq6n5My6oNLd1o6auJApGCsv)",
          "35:0:SIG(HbTqJ1Ts3RhJ8Rx4XkNyh1oSKmoZL1kY5U7t9mKTSjAB)",
          "95:0:SIG(2sZF6j2PkxBDNAqUde7Dgo5x3crkerZpQ4rBqqJGn8QT)",
          "10:0:SIG(4bD7J3uA5pH2N9Xqimspf2XxWN4ESM2Az2XBqtSeHvUZ)",
          "60:0:SIG(5gJYnQp8v7bWwk7EWRoL8vCLof1r3y9c6VDdnGSM1GLv)",
          "30:0:SIG(Hxvt6Yj6n7sYud5YCiH6z4NJT4mbuSjBqErVX4V8GE3)",
          "45:0:SIG(AmDcZSEB5MCt8GyZ1VMRt1sUwRH5D7HpXx8YKhMKZ1qa)",
          "15:0:SIG(7G2mS5aCoT4jCL5WfLKQsXfMJaV9d3jVGUGnwq6Tg36J)",
          "40:0:SIG(7vU9BMDhN6fBuRa2iK3JRbC6pqQKb4qDMGsFcQuT5cz)",
          "15:0:SIG(Be1eVp7etVfA7cT6er6dcJ9d5KxGJVY2tzCGGCAz3yG)",
          "50:0:SIG(5dzkzedBWdeqTFCaD7AkKPMPusfRUL1XyFNJWWGYQ9f1)",
          "15:0:SIG(D3krfq6J9AmfpKnS3gQVYoy7NzGCc61vokteTS8LJ4YH)",
          "5:0:SIG(92VdBcvvCWVBc79kNHpqLceiyPuCxrCwNx1zLacsVy2L)",
          "30:0:SIG(9zCYjVtPFzqjuQ3d1vY1FuHhpEuRpafXkiEpwE3RypN1)",
          "5:0:SIG(FEkbc4BfJukSWnCU6Hed6dgwwTuPFTVdgz5LpL4iHr9J)",
          "10:0:SIG(9toSKwQayx462ye94gtJ4JJh69k2KAWfmzjK6kNZBLph)",
          "20:0:SIG(EwXXo4YAG6BuNhifNZrMKAXNDXcYDhFWaZcSu5iZnSUX)",
          "5:0:SIG(9UuWHs3ZDvV4EiViDGf2zJKNUa8V2ot7hH2zPD1C1sj1)",
          "247620:0:SIG(TENGx7WtzFsTXwnbrPEvb6odX2WnqYcnnrjiiLvp1mS)"
        ],
        "unlocks" => [
          "0:SIG(0)",
          "1:SIG(0)",
          "2:SIG(0)"
        ],
        "signatures" => [
          "00000000000000000000000000000000nSBrUWBOlSS9RLg3rTFYA42ClTNXt55QJKr7cUP9caZeJRl8BHAoAQ=="
        ],
        "comment" => "REMU:99501:100000"
      }
    ],
    "raw" =>
      "Version: 10\nType: Block\nCurrency: g1\nNumber: 100003\nPoWMin: 85\nTime: 1520199092\nMedianTime: 1520196079\nUnitBase: 0\nIssuer: DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ\nIssuersFrame: 164\nIssuersFrameVar: 2\nDifferentIssuersCount: 33\nPreviousHash: 0000068D8D2ABEB0A4E7C5B87AD7E108B27CF1DBF7A1CFED04AB700FB3CF36B5\nPreviousIssuer: 4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m\nMembersCount: 778\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nTX:10:1:3:3:39:1:0\n100001-00000273D97983AA983A5E179AC5F02B40A2E9AE2BA45C980EDC35D885FC4AFF\nTENGx7WtzFsTXwnbrPEvb6odX2WnqYcnnrjiiLvp1mS\n220100:0:T:B708270B661161DA6A8CF68B7B80895864CAA991F9CABD8D4A06D68CAE7C1DBE:33\n10000:0:T:FDB0C5E8318D4253205BB75FDFAEF259A802124FEC1AD3794D525F7951D85658:0\n20020:0:T:EC09188639DC8125FB30B2B8B9BE733F8AE267CA6AEE5466075B940B64E59592:0\n0:SIG(0)\n1:SIG(0)\n2:SIG(0)\n90:0:SIG(2ZPiZZLKsUitStqyv28e4cipchxDQiPZxEYNN6xmqxJx)\n135:0:SIG(98wvdsHGnnNDczKMp6FM9KUuPRBTwn77PN4x6EC6i9KN)\n105:0:SIG(FVUFRrk1K5TQGsY7PRLwqHgdHRoHrwb1hcucp4C2N5tD)\n190:0:SIG(GRBPV3Y7PQnB9LaZhSGuS3BqBJbSHyibzYq65kTh1nQ4)\n120:0:SIG(6fFt4zdvtNyVcfJn7Y41mKLmMDizyK3nVeNW3qdDXzpc)\n155:0:SIG(DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ)\n130:0:SIG(4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m)\n160:0:SIG(D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx)\n155:0:SIG(38MEAZN68Pz1DTvT3tqgxx4yQP6snJCQhPqEFxbDk4aE)\n105:0:SIG(CV1GNhPpVisWZMe3THGnGLca5KkyfbTra5UgkFgKUJTm)\n85:0:SIG(FSAPnBZidfUaiURd1qxwmx4z5VGEPvYfthWfq5vfwGFB)\n80:0:SIG(4GX5gUFwKg8Y8oL5ZFwFD64U3vEJo6CtY61Y3J8LMCHk)\n70:0:SIG(CRBxCJrTA6tmHsgt9cQh9SHcCc8w8q95YTp38CPHx2Uk)\n15:0:SIG(3wdDzBz18mWupx1UChMnhky2Nut3XVnyn9U7Y662J7yE)\n85:0:SIG(81t4UcqmrVnRqGaQwc2zSmoe1bM5G4vQ7fPxbTeD8a5X)\n45:0:SIG(7AQzQb475tEzCkSLKD4HffeQbckizJWFvubhYA2rfwgt)\n100:0:SIG(GfKERHnJTYzKhKUma5h1uWhetbA8yHKymhVH2raf2aCP)\n60:0:SIG(5kpscasQx9p45TXJxtGV17G1Fw9URmMeqouz3x8FNYpB)\n25:0:SIG(6FqjGokAhv6rfXZSmiZs4u9CBJqTFtLZNQXE7Qw2RTNZ)\n85:0:SIG(2ny7YAdmzReQxAayyJZsyVYwYhVyax2thKcGknmQy5nQ)\n20:0:SIG(5cnvo5bmR8QbtyNVnkDXWq6n5My6oNLd1o6auJApGCsv)\n35:0:SIG(HbTqJ1Ts3RhJ8Rx4XkNyh1oSKmoZL1kY5U7t9mKTSjAB)\n95:0:SIG(2sZF6j2PkxBDNAqUde7Dgo5x3crkerZpQ4rBqqJGn8QT)\n10:0:SIG(4bD7J3uA5pH2N9Xqimspf2XxWN4ESM2Az2XBqtSeHvUZ)\n60:0:SIG(5gJYnQp8v7bWwk7EWRoL8vCLof1r3y9c6VDdnGSM1GLv)\n30:0:SIG(Hxvt6Yj6n7sYud5YCiH6z4NJT4mbuSjBqErVX4V8GE3)\n45:0:SIG(AmDcZSEB5MCt8GyZ1VMRt1sUwRH5D7HpXx8YKhMKZ1qa)\n15:0:SIG(7G2mS5aCoT4jCL5WfLKQsXfMJaV9d3jVGUGnwq6Tg36J)\n40:0:SIG(7vU9BMDhN6fBuRa2iK3JRbC6pqQKb4qDMGsFcQuT5cz)\n15:0:SIG(Be1eVp7etVfA7cT6er6dcJ9d5KxGJVY2tzCGGCAz3yG)\n50:0:SIG(5dzkzedBWdeqTFCaD7AkKPMPusfRUL1XyFNJWWGYQ9f1)\n15:0:SIG(D3krfq6J9AmfpKnS3gQVYoy7NzGCc61vokteTS8LJ4YH)\n5:0:SIG(92VdBcvvCWVBc79kNHpqLceiyPuCxrCwNx1zLacsVy2L)\n30:0:SIG(9zCYjVtPFzqjuQ3d1vY1FuHhpEuRpafXkiEpwE3RypN1)\n5:0:SIG(FEkbc4BfJukSWnCU6Hed6dgwwTuPFTVdgz5LpL4iHr9J)\n10:0:SIG(9toSKwQayx462ye94gtJ4JJh69k2KAWfmzjK6kNZBLph)\n20:0:SIG(EwXXo4YAG6BuNhifNZrMKAXNDXcYDhFWaZcSu5iZnSUX)\n5:0:SIG(9UuWHs3ZDvV4EiViDGf2zJKNUa8V2ot7hH2zPD1C1sj1)\n247620:0:SIG(TENGx7WtzFsTXwnbrPEvb6odX2WnqYcnnrjiiLvp1mS)\nREMU:99501:100000\nnnQLYOsiXa9fqy7dHTm1gA+Wwru3MJl6nSBrUWBOlSS9RLg3rTFYA42ClTNXt55QJKr7cUP9caZeJRl8BHAoAQ==\nInnerHash: D6617F43EC29E34B71AB9ADFFAA929E59C2FA3D3BF58F2E26B5D8DBB4271009B\nNonce: 10700000025540\n"
  }

  @two_issuers_correct %{
    "version" => 10,
    "nonce" => 10_700_000_025_540,
    "number" => 100_003,
    "powMin" => 85,
    "time" => 1_520_199_092,
    "medianTime" => 1_520_196_079,
    "membersCount" => 778,
    "monetaryMass" => 116_290_194,
    "unitbase" => 0,
    "issuersCount" => 33,
    "issuersFrame" => 164,
    "issuersFrameVar" => 2,
    "currency" => "g1",
    "issuer" => "DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ",
    "signature" =>
      "2AxFJcjoayRcbWicD+8i1jJg49xhhnTCm1yVAYEH5xCCsQ4YCYXwN3fM8vSn7Iaha/3qj1iRVTH8oqz6E+AQDg==",
    "hash" => "0000023847D63D9E707053A7B4F2DB53902FB0765D4DE604294146FC2412941D",
    "parameters" => "",
    "previousHash" => "0000068D8D2ABEB0A4E7C5B87AD7E108B27CF1DBF7A1CFED04AB700FB3CF36B5",
    "previousIssuer" => "4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m",
    "inner_hash" => "D6617F43EC29E34B71AB9ADFFAA929E59C2FA3D3BF58F2E26B5D8DBB4271009B",
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
        "locktime" => 0,
        "hash" => "676D38DA93A4071729CFB85B077C8D753037C822A7A842354DD554873A42D7D4",
        "blockstamp" => "100001-00000273D97983AA983A5E179AC5F02B40A2E9AE2BA45C980EDC35D885FC4AFF",
        "blockstampTime" => 0,
        "issuers" => [
          "4h6X2zW8jLcpxwcb8m6K5X5rSsok68oobn1gwy4dc5yK",
          "DYiFWnPsQyp8kmPSPVcfLjRzKHUJK8WtBKLJmGJN9MXk"
        ],
        "inputs" => [
          "220100:0:T:B708270B661161DA6A8CF68B7B80895864CAA991F9CABD8D4A06D68CAE7C1DBE:33"
        ],
        "outputs" => [
          "90:0:SIG(2ZPiZZLKsUitStqyv28e4cipchxDQiPZxEYNN6xmqxJx)"
        ],
        "unlocks" => [
          "0:SIG(0)"
        ],
        "signatures" => [
          "/P8bS0BNI0ZpbE7PEsF7KwNGbJd9u2nJcGE8Qggl6u4JngI8VjuW+bVvY3r14PssxAgT6vJ3iHqd32BNol0kAw==",
          "VIrXNDBnFgz+1g9Ksj2Vb8p7QHEEQN2DhzQx83FEL6bWbY5NsxZwOv4QoqDdi4ZH9bevQj/sxlGCukZuJEYkCA=="
        ],
        "comment" => "REMU:99501:100000"
      }
    ],
    "raw" =>
      "Version: 10\nType: Block\nCurrency: g1\nNumber: 100003\nPoWMin: 85\nTime: 1520199092\nMedianTime: 1520196079\nUnitBase: 0\nIssuer: DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ\nIssuersFrame: 164\nIssuersFrameVar: 2\nDifferentIssuersCount: 33\nPreviousHash: 0000068D8D2ABEB0A4E7C5B87AD7E108B27CF1DBF7A1CFED04AB700FB3CF36B5\nPreviousIssuer: 4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m\nMembersCount: 778\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nTX:10:1:3:3:39:1:0\n100001-00000273D97983AA983A5E179AC5F02B40A2E9AE2BA45C980EDC35D885FC4AFF\nTENGx7WtzFsTXwnbrPEvb6odX2WnqYcnnrjiiLvp1mS\n220100:0:T:B708270B661161DA6A8CF68B7B80895864CAA991F9CABD8D4A06D68CAE7C1DBE:33\n10000:0:T:FDB0C5E8318D4253205BB75FDFAEF259A802124FEC1AD3794D525F7951D85658:0\n20020:0:T:EC09188639DC8125FB30B2B8B9BE733F8AE267CA6AEE5466075B940B64E59592:0\n0:SIG(0)\n1:SIG(0)\n2:SIG(0)\n90:0:SIG(2ZPiZZLKsUitStqyv28e4cipchxDQiPZxEYNN6xmqxJx)\n135:0:SIG(98wvdsHGnnNDczKMp6FM9KUuPRBTwn77PN4x6EC6i9KN)\n105:0:SIG(FVUFRrk1K5TQGsY7PRLwqHgdHRoHrwb1hcucp4C2N5tD)\n190:0:SIG(GRBPV3Y7PQnB9LaZhSGuS3BqBJbSHyibzYq65kTh1nQ4)\n120:0:SIG(6fFt4zdvtNyVcfJn7Y41mKLmMDizyK3nVeNW3qdDXzpc)\n155:0:SIG(DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ)\n130:0:SIG(4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m)\n160:0:SIG(D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx)\n155:0:SIG(38MEAZN68Pz1DTvT3tqgxx4yQP6snJCQhPqEFxbDk4aE)\n105:0:SIG(CV1GNhPpVisWZMe3THGnGLca5KkyfbTra5UgkFgKUJTm)\n85:0:SIG(FSAPnBZidfUaiURd1qxwmx4z5VGEPvYfthWfq5vfwGFB)\n80:0:SIG(4GX5gUFwKg8Y8oL5ZFwFD64U3vEJo6CtY61Y3J8LMCHk)\n70:0:SIG(CRBxCJrTA6tmHsgt9cQh9SHcCc8w8q95YTp38CPHx2Uk)\n15:0:SIG(3wdDzBz18mWupx1UChMnhky2Nut3XVnyn9U7Y662J7yE)\n85:0:SIG(81t4UcqmrVnRqGaQwc2zSmoe1bM5G4vQ7fPxbTeD8a5X)\n45:0:SIG(7AQzQb475tEzCkSLKD4HffeQbckizJWFvubhYA2rfwgt)\n100:0:SIG(GfKERHnJTYzKhKUma5h1uWhetbA8yHKymhVH2raf2aCP)\n60:0:SIG(5kpscasQx9p45TXJxtGV17G1Fw9URmMeqouz3x8FNYpB)\n25:0:SIG(6FqjGokAhv6rfXZSmiZs4u9CBJqTFtLZNQXE7Qw2RTNZ)\n85:0:SIG(2ny7YAdmzReQxAayyJZsyVYwYhVyax2thKcGknmQy5nQ)\n20:0:SIG(5cnvo5bmR8QbtyNVnkDXWq6n5My6oNLd1o6auJApGCsv)\n35:0:SIG(HbTqJ1Ts3RhJ8Rx4XkNyh1oSKmoZL1kY5U7t9mKTSjAB)\n95:0:SIG(2sZF6j2PkxBDNAqUde7Dgo5x3crkerZpQ4rBqqJGn8QT)\n10:0:SIG(4bD7J3uA5pH2N9Xqimspf2XxWN4ESM2Az2XBqtSeHvUZ)\n60:0:SIG(5gJYnQp8v7bWwk7EWRoL8vCLof1r3y9c6VDdnGSM1GLv)\n30:0:SIG(Hxvt6Yj6n7sYud5YCiH6z4NJT4mbuSjBqErVX4V8GE3)\n45:0:SIG(AmDcZSEB5MCt8GyZ1VMRt1sUwRH5D7HpXx8YKhMKZ1qa)\n15:0:SIG(7G2mS5aCoT4jCL5WfLKQsXfMJaV9d3jVGUGnwq6Tg36J)\n40:0:SIG(7vU9BMDhN6fBuRa2iK3JRbC6pqQKb4qDMGsFcQuT5cz)\n15:0:SIG(Be1eVp7etVfA7cT6er6dcJ9d5KxGJVY2tzCGGCAz3yG)\n50:0:SIG(5dzkzedBWdeqTFCaD7AkKPMPusfRUL1XyFNJWWGYQ9f1)\n15:0:SIG(D3krfq6J9AmfpKnS3gQVYoy7NzGCc61vokteTS8LJ4YH)\n5:0:SIG(92VdBcvvCWVBc79kNHpqLceiyPuCxrCwNx1zLacsVy2L)\n30:0:SIG(9zCYjVtPFzqjuQ3d1vY1FuHhpEuRpafXkiEpwE3RypN1)\n5:0:SIG(FEkbc4BfJukSWnCU6Hed6dgwwTuPFTVdgz5LpL4iHr9J)\n10:0:SIG(9toSKwQayx462ye94gtJ4JJh69k2KAWfmzjK6kNZBLph)\n20:0:SIG(EwXXo4YAG6BuNhifNZrMKAXNDXcYDhFWaZcSu5iZnSUX)\n5:0:SIG(9UuWHs3ZDvV4EiViDGf2zJKNUa8V2ot7hH2zPD1C1sj1)\n247620:0:SIG(TENGx7WtzFsTXwnbrPEvb6odX2WnqYcnnrjiiLvp1mS)\nREMU:99501:100000\nnnQLYOsiXa9fqy7dHTm1gA+Wwru3MJl6nSBrUWBOlSS9RLg3rTFYA42ClTNXt55QJKr7cUP9caZeJRl8BHAoAQ==\nInnerHash: D6617F43EC29E34B71AB9ADFFAA929E59C2FA3D3BF58F2E26B5D8DBB4271009B\nNonce: 10700000025540\n"
  }

  @two_issuers_correct %{
    "version" => 10,
    "nonce" => 10_700_000_025_540,
    "number" => 100_003,
    "powMin" => 85,
    "time" => 1_520_199_092,
    "medianTime" => 1_520_196_079,
    "membersCount" => 778,
    "monetaryMass" => 116_290_194,
    "unitbase" => 0,
    "issuersCount" => 33,
    "issuersFrame" => 164,
    "issuersFrameVar" => 2,
    "currency" => "g1",
    "issuer" => "DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ",
    "signature" =>
      "2AxFJcjoayRcbWicD+8i1jJg49xhhnTCm1yVAYEH5xCCsQ4YCYXwN3fM8vSn7Iaha/3qj1iRVTH8oqz6E+AQDg==",
    "hash" => "0000023847D63D9E707053A7B4F2DB53902FB0765D4DE604294146FC2412941D",
    "parameters" => "",
    "previousHash" => "0000068D8D2ABEB0A4E7C5B87AD7E108B27CF1DBF7A1CFED04AB700FB3CF36B5",
    "previousIssuer" => "4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m",
    "inner_hash" => "D6617F43EC29E34B71AB9ADFFAA929E59C2FA3D3BF58F2E26B5D8DBB4271009B",
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
        "locktime" => 0,
        "hash" => "676D38DA93A4071729CFB85B077C8D753037C822A7A842354DD554873A42D7D4",
        "blockstamp" => "100001-00000273D97983AA983A5E179AC5F02B40A2E9AE2BA45C980EDC35D885FC4AFF",
        "blockstampTime" => 0,
        "issuers" => [
          "4h6X2zW8jLcpxwcb8m6K5X5rSsok68oobn1gwy4dc5yK",
          "DYiFWnPsQyp8kmPSPVcfLjRzKHUJK8WtBKLJmGJN9MXk"
        ],
        "inputs" => [
          "220100:0:T:B708270B661161DA6A8CF68B7B80895864CAA991F9CABD8D4A06D68CAE7C1DBE:33"
        ],
        "outputs" => [
          "90:0:SIG(2ZPiZZLKsUitStqyv28e4cipchxDQiPZxEYNN6xmqxJx)"
        ],
        "unlocks" => [
          "0:SIG(0)"
        ],
        "signatures" => [
          "/P8bS0BNI0ZpbE7PEsF7KwNGbJd9u2nJcGE8Qggl6u4JngI8VjuW+bVvY3r14PssxAgT6vJ3iHqd32BNol0kAw==",
          "VIrXNDBnFgz+1g9Ksj2Vb8p7QHEEQN2DhzQx83FEL6bWbY5NsxZwOv4QoqDdi4ZH9bevQj/sxlGCukZuJEYkCA=="
        ],
        "comment" => "REMU:99501:100000"
      }
    ],
    "raw" =>
      "Version: 10\nType: Block\nCurrency: g1\nNumber: 100003\nPoWMin: 85\nTime: 1520199092\nMedianTime: 1520196079\nUnitBase: 0\nIssuer: DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ\nIssuersFrame: 164\nIssuersFrameVar: 2\nDifferentIssuersCount: 33\nPreviousHash: 0000068D8D2ABEB0A4E7C5B87AD7E108B27CF1DBF7A1CFED04AB700FB3CF36B5\nPreviousIssuer: 4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m\nMembersCount: 778\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nTX:10:1:3:3:39:1:0\n100001-00000273D97983AA983A5E179AC5F02B40A2E9AE2BA45C980EDC35D885FC4AFF\nTENGx7WtzFsTXwnbrPEvb6odX2WnqYcnnrjiiLvp1mS\n220100:0:T:B708270B661161DA6A8CF68B7B80895864CAA991F9CABD8D4A06D68CAE7C1DBE:33\n10000:0:T:FDB0C5E8318D4253205BB75FDFAEF259A802124FEC1AD3794D525F7951D85658:0\n20020:0:T:EC09188639DC8125FB30B2B8B9BE733F8AE267CA6AEE5466075B940B64E59592:0\n0:SIG(0)\n1:SIG(0)\n2:SIG(0)\n90:0:SIG(2ZPiZZLKsUitStqyv28e4cipchxDQiPZxEYNN6xmqxJx)\n135:0:SIG(98wvdsHGnnNDczKMp6FM9KUuPRBTwn77PN4x6EC6i9KN)\n105:0:SIG(FVUFRrk1K5TQGsY7PRLwqHgdHRoHrwb1hcucp4C2N5tD)\n190:0:SIG(GRBPV3Y7PQnB9LaZhSGuS3BqBJbSHyibzYq65kTh1nQ4)\n120:0:SIG(6fFt4zdvtNyVcfJn7Y41mKLmMDizyK3nVeNW3qdDXzpc)\n155:0:SIG(DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ)\n130:0:SIG(4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m)\n160:0:SIG(D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx)\n155:0:SIG(38MEAZN68Pz1DTvT3tqgxx4yQP6snJCQhPqEFxbDk4aE)\n105:0:SIG(CV1GNhPpVisWZMe3THGnGLca5KkyfbTra5UgkFgKUJTm)\n85:0:SIG(FSAPnBZidfUaiURd1qxwmx4z5VGEPvYfthWfq5vfwGFB)\n80:0:SIG(4GX5gUFwKg8Y8oL5ZFwFD64U3vEJo6CtY61Y3J8LMCHk)\n70:0:SIG(CRBxCJrTA6tmHsgt9cQh9SHcCc8w8q95YTp38CPHx2Uk)\n15:0:SIG(3wdDzBz18mWupx1UChMnhky2Nut3XVnyn9U7Y662J7yE)\n85:0:SIG(81t4UcqmrVnRqGaQwc2zSmoe1bM5G4vQ7fPxbTeD8a5X)\n45:0:SIG(7AQzQb475tEzCkSLKD4HffeQbckizJWFvubhYA2rfwgt)\n100:0:SIG(GfKERHnJTYzKhKUma5h1uWhetbA8yHKymhVH2raf2aCP)\n60:0:SIG(5kpscasQx9p45TXJxtGV17G1Fw9URmMeqouz3x8FNYpB)\n25:0:SIG(6FqjGokAhv6rfXZSmiZs4u9CBJqTFtLZNQXE7Qw2RTNZ)\n85:0:SIG(2ny7YAdmzReQxAayyJZsyVYwYhVyax2thKcGknmQy5nQ)\n20:0:SIG(5cnvo5bmR8QbtyNVnkDXWq6n5My6oNLd1o6auJApGCsv)\n35:0:SIG(HbTqJ1Ts3RhJ8Rx4XkNyh1oSKmoZL1kY5U7t9mKTSjAB)\n95:0:SIG(2sZF6j2PkxBDNAqUde7Dgo5x3crkerZpQ4rBqqJGn8QT)\n10:0:SIG(4bD7J3uA5pH2N9Xqimspf2XxWN4ESM2Az2XBqtSeHvUZ)\n60:0:SIG(5gJYnQp8v7bWwk7EWRoL8vCLof1r3y9c6VDdnGSM1GLv)\n30:0:SIG(Hxvt6Yj6n7sYud5YCiH6z4NJT4mbuSjBqErVX4V8GE3)\n45:0:SIG(AmDcZSEB5MCt8GyZ1VMRt1sUwRH5D7HpXx8YKhMKZ1qa)\n15:0:SIG(7G2mS5aCoT4jCL5WfLKQsXfMJaV9d3jVGUGnwq6Tg36J)\n40:0:SIG(7vU9BMDhN6fBuRa2iK3JRbC6pqQKb4qDMGsFcQuT5cz)\n15:0:SIG(Be1eVp7etVfA7cT6er6dcJ9d5KxGJVY2tzCGGCAz3yG)\n50:0:SIG(5dzkzedBWdeqTFCaD7AkKPMPusfRUL1XyFNJWWGYQ9f1)\n15:0:SIG(D3krfq6J9AmfpKnS3gQVYoy7NzGCc61vokteTS8LJ4YH)\n5:0:SIG(92VdBcvvCWVBc79kNHpqLceiyPuCxrCwNx1zLacsVy2L)\n30:0:SIG(9zCYjVtPFzqjuQ3d1vY1FuHhpEuRpafXkiEpwE3RypN1)\n5:0:SIG(FEkbc4BfJukSWnCU6Hed6dgwwTuPFTVdgz5LpL4iHr9J)\n10:0:SIG(9toSKwQayx462ye94gtJ4JJh69k2KAWfmzjK6kNZBLph)\n20:0:SIG(EwXXo4YAG6BuNhifNZrMKAXNDXcYDhFWaZcSu5iZnSUX)\n5:0:SIG(9UuWHs3ZDvV4EiViDGf2zJKNUa8V2ot7hH2zPD1C1sj1)\n247620:0:SIG(TENGx7WtzFsTXwnbrPEvb6odX2WnqYcnnrjiiLvp1mS)\nREMU:99501:100000\nnnQLYOsiXa9fqy7dHTm1gA+Wwru3MJl6nSBrUWBOlSS9RLg3rTFYA42ClTNXt55QJKr7cUP9caZeJRl8BHAoAQ==\nInnerHash: D6617F43EC29E34B71AB9ADFFAA929E59C2FA3D3BF58F2E26B5D8DBB4271009B\nNonce: 10700000025540\n"
  }

  @two_issuers_wrong_order %{
    "version" => 10,
    "nonce" => 10_700_000_025_540,
    "number" => 100_003,
    "powMin" => 85,
    "time" => 1_520_199_092,
    "medianTime" => 1_520_196_079,
    "membersCount" => 778,
    "monetaryMass" => 116_290_194,
    "unitbase" => 0,
    "issuersCount" => 33,
    "issuersFrame" => 164,
    "issuersFrameVar" => 2,
    "currency" => "g1",
    "issuer" => "DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ",
    "signature" =>
      "2AxFJcjoayRcbWicD+8i1jJg49xhhnTCm1yVAYEH5xCCsQ4YCYXwN3fM8vSn7Iaha/3qj1iRVTH8oqz6E+AQDg==",
    "hash" => "0000023847D63D9E707053A7B4F2DB53902FB0765D4DE604294146FC2412941D",
    "parameters" => "",
    "previousHash" => "0000068D8D2ABEB0A4E7C5B87AD7E108B27CF1DBF7A1CFED04AB700FB3CF36B5",
    "previousIssuer" => "4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m",
    "inner_hash" => "D6617F43EC29E34B71AB9ADFFAA929E59C2FA3D3BF58F2E26B5D8DBB4271009B",
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
        "locktime" => 0,
        "hash" => "676D38DA93A4071729CFB85B077C8D753037C822A7A842354DD554873A42D7D4",
        "blockstamp" => "100001-00000273D97983AA983A5E179AC5F02B40A2E9AE2BA45C980EDC35D885FC4AFF",
        "blockstampTime" => 0,
        "issuers" => [
          "4h6X2zW8jLcpxwcb8m6K5X5rSsok68oobn1gwy4dc5yK",
          "DYiFWnPsQyp8kmPSPVcfLjRzKHUJK8WtBKLJmGJN9MXk"
        ],
        "inputs" => [
          "220100:0:T:B708270B661161DA6A8CF68B7B80895864CAA991F9CABD8D4A06D68CAE7C1DBE:33"
        ],
        "outputs" => [
          "90:0:SIG(2ZPiZZLKsUitStqyv28e4cipchxDQiPZxEYNN6xmqxJx)"
        ],
        "unlocks" => [
          "0:SIG(0)"
        ],
        "signatures" => [
          "VIrXNDBnFgz+1g9Ksj2Vb8p7QHEEQN2DhzQx83FEL6bWbY5NsxZwOv4QoqDdi4ZH9bevQj/sxlGCukZuJEYkCA==",
          "/P8bS0BNI0ZpbE7PEsF7KwNGbJd9u2nJcGE8Qggl6u4JngI8VjuW+bVvY3r14PssxAgT6vJ3iHqd32BNol0kAw=="
        ],
        "comment" => "REMU:99501:100000"
      }
    ],
    "raw" =>
      "Version: 10\nType: Block\nCurrency: g1\nNumber: 100003\nPoWMin: 85\nTime: 1520199092\nMedianTime: 1520196079\nUnitBase: 0\nIssuer: DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ\nIssuersFrame: 164\nIssuersFrameVar: 2\nDifferentIssuersCount: 33\nPreviousHash: 0000068D8D2ABEB0A4E7C5B87AD7E108B27CF1DBF7A1CFED04AB700FB3CF36B5\nPreviousIssuer: 4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m\nMembersCount: 778\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nTX:10:1:3:3:39:1:0\n100001-00000273D97983AA983A5E179AC5F02B40A2E9AE2BA45C980EDC35D885FC4AFF\nTENGx7WtzFsTXwnbrPEvb6odX2WnqYcnnrjiiLvp1mS\n220100:0:T:B708270B661161DA6A8CF68B7B80895864CAA991F9CABD8D4A06D68CAE7C1DBE:33\n10000:0:T:FDB0C5E8318D4253205BB75FDFAEF259A802124FEC1AD3794D525F7951D85658:0\n20020:0:T:EC09188639DC8125FB30B2B8B9BE733F8AE267CA6AEE5466075B940B64E59592:0\n0:SIG(0)\n1:SIG(0)\n2:SIG(0)\n90:0:SIG(2ZPiZZLKsUitStqyv28e4cipchxDQiPZxEYNN6xmqxJx)\n135:0:SIG(98wvdsHGnnNDczKMp6FM9KUuPRBTwn77PN4x6EC6i9KN)\n105:0:SIG(FVUFRrk1K5TQGsY7PRLwqHgdHRoHrwb1hcucp4C2N5tD)\n190:0:SIG(GRBPV3Y7PQnB9LaZhSGuS3BqBJbSHyibzYq65kTh1nQ4)\n120:0:SIG(6fFt4zdvtNyVcfJn7Y41mKLmMDizyK3nVeNW3qdDXzpc)\n155:0:SIG(DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ)\n130:0:SIG(4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m)\n160:0:SIG(D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx)\n155:0:SIG(38MEAZN68Pz1DTvT3tqgxx4yQP6snJCQhPqEFxbDk4aE)\n105:0:SIG(CV1GNhPpVisWZMe3THGnGLca5KkyfbTra5UgkFgKUJTm)\n85:0:SIG(FSAPnBZidfUaiURd1qxwmx4z5VGEPvYfthWfq5vfwGFB)\n80:0:SIG(4GX5gUFwKg8Y8oL5ZFwFD64U3vEJo6CtY61Y3J8LMCHk)\n70:0:SIG(CRBxCJrTA6tmHsgt9cQh9SHcCc8w8q95YTp38CPHx2Uk)\n15:0:SIG(3wdDzBz18mWupx1UChMnhky2Nut3XVnyn9U7Y662J7yE)\n85:0:SIG(81t4UcqmrVnRqGaQwc2zSmoe1bM5G4vQ7fPxbTeD8a5X)\n45:0:SIG(7AQzQb475tEzCkSLKD4HffeQbckizJWFvubhYA2rfwgt)\n100:0:SIG(GfKERHnJTYzKhKUma5h1uWhetbA8yHKymhVH2raf2aCP)\n60:0:SIG(5kpscasQx9p45TXJxtGV17G1Fw9URmMeqouz3x8FNYpB)\n25:0:SIG(6FqjGokAhv6rfXZSmiZs4u9CBJqTFtLZNQXE7Qw2RTNZ)\n85:0:SIG(2ny7YAdmzReQxAayyJZsyVYwYhVyax2thKcGknmQy5nQ)\n20:0:SIG(5cnvo5bmR8QbtyNVnkDXWq6n5My6oNLd1o6auJApGCsv)\n35:0:SIG(HbTqJ1Ts3RhJ8Rx4XkNyh1oSKmoZL1kY5U7t9mKTSjAB)\n95:0:SIG(2sZF6j2PkxBDNAqUde7Dgo5x3crkerZpQ4rBqqJGn8QT)\n10:0:SIG(4bD7J3uA5pH2N9Xqimspf2XxWN4ESM2Az2XBqtSeHvUZ)\n60:0:SIG(5gJYnQp8v7bWwk7EWRoL8vCLof1r3y9c6VDdnGSM1GLv)\n30:0:SIG(Hxvt6Yj6n7sYud5YCiH6z4NJT4mbuSjBqErVX4V8GE3)\n45:0:SIG(AmDcZSEB5MCt8GyZ1VMRt1sUwRH5D7HpXx8YKhMKZ1qa)\n15:0:SIG(7G2mS5aCoT4jCL5WfLKQsXfMJaV9d3jVGUGnwq6Tg36J)\n40:0:SIG(7vU9BMDhN6fBuRa2iK3JRbC6pqQKb4qDMGsFcQuT5cz)\n15:0:SIG(Be1eVp7etVfA7cT6er6dcJ9d5KxGJVY2tzCGGCAz3yG)\n50:0:SIG(5dzkzedBWdeqTFCaD7AkKPMPusfRUL1XyFNJWWGYQ9f1)\n15:0:SIG(D3krfq6J9AmfpKnS3gQVYoy7NzGCc61vokteTS8LJ4YH)\n5:0:SIG(92VdBcvvCWVBc79kNHpqLceiyPuCxrCwNx1zLacsVy2L)\n30:0:SIG(9zCYjVtPFzqjuQ3d1vY1FuHhpEuRpafXkiEpwE3RypN1)\n5:0:SIG(FEkbc4BfJukSWnCU6Hed6dgwwTuPFTVdgz5LpL4iHr9J)\n10:0:SIG(9toSKwQayx462ye94gtJ4JJh69k2KAWfmzjK6kNZBLph)\n20:0:SIG(EwXXo4YAG6BuNhifNZrMKAXNDXcYDhFWaZcSu5iZnSUX)\n5:0:SIG(9UuWHs3ZDvV4EiViDGf2zJKNUa8V2ot7hH2zPD1C1sj1)\n247620:0:SIG(TENGx7WtzFsTXwnbrPEvb6odX2WnqYcnnrjiiLvp1mS)\nREMU:99501:100000\nnnQLYOsiXa9fqy7dHTm1gA+Wwru3MJl6nSBrUWBOlSS9RLg3rTFYA42ClTNXt55QJKr7cUP9caZeJRl8BHAoAQ==\nInnerHash: D6617F43EC29E34B71AB9ADFFAA929E59C2FA3D3BF58F2E26B5D8DBB4271009B\nNonce: 10700000025540\n"
  }

  @two_tx_correct %{
    "version" => 10,
    "nonce" => 10_700_000_025_540,
    "number" => 100_003,
    "powMin" => 85,
    "time" => 1_520_199_092,
    "medianTime" => 1_520_196_079,
    "membersCount" => 778,
    "monetaryMass" => 116_290_194,
    "unitbase" => 0,
    "issuersCount" => 33,
    "issuersFrame" => 164,
    "issuersFrameVar" => 2,
    "currency" => "g1",
    "issuer" => "DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ",
    "signature" =>
      "2AxFJcjoayRcbWicD+8i1jJg49xhhnTCm1yVAYEH5xCCsQ4YCYXwN3fM8vSn7Iaha/3qj1iRVTH8oqz6E+AQDg==",
    "hash" => "0000023847D63D9E707053A7B4F2DB53902FB0765D4DE604294146FC2412941D",
    "parameters" => "",
    "previousHash" => "0000068D8D2ABEB0A4E7C5B87AD7E108B27CF1DBF7A1CFED04AB700FB3CF36B5",
    "previousIssuer" => "4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m",
    "inner_hash" => "D6617F43EC29E34B71AB9ADFFAA929E59C2FA3D3BF58F2E26B5D8DBB4271009B",
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
        "locktime" => 0,
        "hash" => "676D38DA93A4071729CFB85B077C8D753037C822A7A842354DD554873A42D7D4",
        "blockstamp" => "100001-00000273D97983AA983A5E179AC5F02B40A2E9AE2BA45C980EDC35D885FC4AFF",
        "blockstampTime" => 0,
        "issuers" => [
          "4h6X2zW8jLcpxwcb8m6K5X5rSsok68oobn1gwy4dc5yK",
          "DYiFWnPsQyp8kmPSPVcfLjRzKHUJK8WtBKLJmGJN9MXk"
        ],
        "inputs" => [
          "220100:0:T:B708270B661161DA6A8CF68B7B80895864CAA991F9CABD8D4A06D68CAE7C1DBE:33"
        ],
        "outputs" => [
          "90:0:SIG(2ZPiZZLKsUitStqyv28e4cipchxDQiPZxEYNN6xmqxJx)"
        ],
        "unlocks" => [
          "0:SIG(0)"
        ],
        "signatures" => [
          "/P8bS0BNI0ZpbE7PEsF7KwNGbJd9u2nJcGE8Qggl6u4JngI8VjuW+bVvY3r14PssxAgT6vJ3iHqd32BNol0kAw==",
          "VIrXNDBnFgz+1g9Ksj2Vb8p7QHEEQN2DhzQx83FEL6bWbY5NsxZwOv4QoqDdi4ZH9bevQj/sxlGCukZuJEYkCA=="
        ],
        "comment" => "REMU:99501:100000"
      },
      %{
        "version" => 10,
        "currency" => "g1",
        "locktime" => 0,
        "hash" => "676D38DA93A4071729CFB85B077C8D753037C822A7A842354DD554873A42D7D4",
        "blockstamp" => "100001-00000273D97983AA983A5E179AC5F02B40A2E9AE2BA45C980EDC35D885FC4AFF",
        "blockstampTime" => 0,
        "issuers" => [
          "4h6X2zW8jLcpxwcb8m6K5X5rSsok68oobn1gwy4dc5yK",
          "DYiFWnPsQyp8kmPSPVcfLjRzKHUJK8WtBKLJmGJN9MXk"
        ],
        "inputs" => [
          "220100:0:T:B708270B661161DA6A8CF68B7B80895864CAA991F9CABD8D4A06D68CAE7C1DBE:33"
        ],
        "outputs" => [
          "90:0:SIG(2ZPiZZLKsUitStqyv28e4cipchxDQiPZxEYNN6xmqxJx)"
        ],
        "unlocks" => [
          "0:SIG(0)"
        ],
        "signatures" => [
          "/P8bS0BNI0ZpbE7PEsF7KwNGbJd9u2nJcGE8Qggl6u4JngI8VjuW+bVvY3r14PssxAgT6vJ3iHqd32BNol0kAw==",
          "VIrXNDBnFgz+1g9Ksj2Vb8p7QHEEQN2DhzQx83FEL6bWbY5NsxZwOv4QoqDdi4ZH9bevQj/sxlGCukZuJEYkCA=="
        ],
        "comment" => "REMU:99501:100000"
      }
    ],
    "raw" =>
      "Version: 10\nType: Block\nCurrency: g1\nNumber: 100003\nPoWMin: 85\nTime: 1520199092\nMedianTime: 1520196079\nUnitBase: 0\nIssuer: DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ\nIssuersFrame: 164\nIssuersFrameVar: 2\nDifferentIssuersCount: 33\nPreviousHash: 0000068D8D2ABEB0A4E7C5B87AD7E108B27CF1DBF7A1CFED04AB700FB3CF36B5\nPreviousIssuer: 4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m\nMembersCount: 778\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nTX:10:1:3:3:39:1:0\n100001-00000273D97983AA983A5E179AC5F02B40A2E9AE2BA45C980EDC35D885FC4AFF\nTENGx7WtzFsTXwnbrPEvb6odX2WnqYcnnrjiiLvp1mS\n220100:0:T:B708270B661161DA6A8CF68B7B80895864CAA991F9CABD8D4A06D68CAE7C1DBE:33\n10000:0:T:FDB0C5E8318D4253205BB75FDFAEF259A802124FEC1AD3794D525F7951D85658:0\n20020:0:T:EC09188639DC8125FB30B2B8B9BE733F8AE267CA6AEE5466075B940B64E59592:0\n0:SIG(0)\n1:SIG(0)\n2:SIG(0)\n90:0:SIG(2ZPiZZLKsUitStqyv28e4cipchxDQiPZxEYNN6xmqxJx)\n135:0:SIG(98wvdsHGnnNDczKMp6FM9KUuPRBTwn77PN4x6EC6i9KN)\n105:0:SIG(FVUFRrk1K5TQGsY7PRLwqHgdHRoHrwb1hcucp4C2N5tD)\n190:0:SIG(GRBPV3Y7PQnB9LaZhSGuS3BqBJbSHyibzYq65kTh1nQ4)\n120:0:SIG(6fFt4zdvtNyVcfJn7Y41mKLmMDizyK3nVeNW3qdDXzpc)\n155:0:SIG(DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ)\n130:0:SIG(4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m)\n160:0:SIG(D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx)\n155:0:SIG(38MEAZN68Pz1DTvT3tqgxx4yQP6snJCQhPqEFxbDk4aE)\n105:0:SIG(CV1GNhPpVisWZMe3THGnGLca5KkyfbTra5UgkFgKUJTm)\n85:0:SIG(FSAPnBZidfUaiURd1qxwmx4z5VGEPvYfthWfq5vfwGFB)\n80:0:SIG(4GX5gUFwKg8Y8oL5ZFwFD64U3vEJo6CtY61Y3J8LMCHk)\n70:0:SIG(CRBxCJrTA6tmHsgt9cQh9SHcCc8w8q95YTp38CPHx2Uk)\n15:0:SIG(3wdDzBz18mWupx1UChMnhky2Nut3XVnyn9U7Y662J7yE)\n85:0:SIG(81t4UcqmrVnRqGaQwc2zSmoe1bM5G4vQ7fPxbTeD8a5X)\n45:0:SIG(7AQzQb475tEzCkSLKD4HffeQbckizJWFvubhYA2rfwgt)\n100:0:SIG(GfKERHnJTYzKhKUma5h1uWhetbA8yHKymhVH2raf2aCP)\n60:0:SIG(5kpscasQx9p45TXJxtGV17G1Fw9URmMeqouz3x8FNYpB)\n25:0:SIG(6FqjGokAhv6rfXZSmiZs4u9CBJqTFtLZNQXE7Qw2RTNZ)\n85:0:SIG(2ny7YAdmzReQxAayyJZsyVYwYhVyax2thKcGknmQy5nQ)\n20:0:SIG(5cnvo5bmR8QbtyNVnkDXWq6n5My6oNLd1o6auJApGCsv)\n35:0:SIG(HbTqJ1Ts3RhJ8Rx4XkNyh1oSKmoZL1kY5U7t9mKTSjAB)\n95:0:SIG(2sZF6j2PkxBDNAqUde7Dgo5x3crkerZpQ4rBqqJGn8QT)\n10:0:SIG(4bD7J3uA5pH2N9Xqimspf2XxWN4ESM2Az2XBqtSeHvUZ)\n60:0:SIG(5gJYnQp8v7bWwk7EWRoL8vCLof1r3y9c6VDdnGSM1GLv)\n30:0:SIG(Hxvt6Yj6n7sYud5YCiH6z4NJT4mbuSjBqErVX4V8GE3)\n45:0:SIG(AmDcZSEB5MCt8GyZ1VMRt1sUwRH5D7HpXx8YKhMKZ1qa)\n15:0:SIG(7G2mS5aCoT4jCL5WfLKQsXfMJaV9d3jVGUGnwq6Tg36J)\n40:0:SIG(7vU9BMDhN6fBuRa2iK3JRbC6pqQKb4qDMGsFcQuT5cz)\n15:0:SIG(Be1eVp7etVfA7cT6er6dcJ9d5KxGJVY2tzCGGCAz3yG)\n50:0:SIG(5dzkzedBWdeqTFCaD7AkKPMPusfRUL1XyFNJWWGYQ9f1)\n15:0:SIG(D3krfq6J9AmfpKnS3gQVYoy7NzGCc61vokteTS8LJ4YH)\n5:0:SIG(92VdBcvvCWVBc79kNHpqLceiyPuCxrCwNx1zLacsVy2L)\n30:0:SIG(9zCYjVtPFzqjuQ3d1vY1FuHhpEuRpafXkiEpwE3RypN1)\n5:0:SIG(FEkbc4BfJukSWnCU6Hed6dgwwTuPFTVdgz5LpL4iHr9J)\n10:0:SIG(9toSKwQayx462ye94gtJ4JJh69k2KAWfmzjK6kNZBLph)\n20:0:SIG(EwXXo4YAG6BuNhifNZrMKAXNDXcYDhFWaZcSu5iZnSUX)\n5:0:SIG(9UuWHs3ZDvV4EiViDGf2zJKNUa8V2ot7hH2zPD1C1sj1)\n247620:0:SIG(TENGx7WtzFsTXwnbrPEvb6odX2WnqYcnnrjiiLvp1mS)\nREMU:99501:100000\nnnQLYOsiXa9fqy7dHTm1gA+Wwru3MJl6nSBrUWBOlSS9RLg3rTFYA42ClTNXt55QJKr7cUP9caZeJRl8BHAoAQ==\nInnerHash: D6617F43EC29E34B71AB9ADFFAA929E59C2FA3D3BF58F2E26B5D8DBB4271009B\nNonce: 10700000025540\n"
  }

  @two_tx_one_wrong %{
    "version" => 10,
    "nonce" => 10_700_000_025_540,
    "number" => 100_003,
    "powMin" => 85,
    "time" => 1_520_199_092,
    "medianTime" => 1_520_196_079,
    "membersCount" => 778,
    "monetaryMass" => 116_290_194,
    "unitbase" => 0,
    "issuersCount" => 33,
    "issuersFrame" => 164,
    "issuersFrameVar" => 2,
    "currency" => "g1",
    "issuer" => "DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ",
    "signature" =>
      "2AxFJcjoayRcbWicD+8i1jJg49xhhnTCm1yVAYEH5xCCsQ4YCYXwN3fM8vSn7Iaha/3qj1iRVTH8oqz6E+AQDg==",
    "hash" => "0000023847D63D9E707053A7B4F2DB53902FB0765D4DE604294146FC2412941D",
    "parameters" => "",
    "previousHash" => "0000068D8D2ABEB0A4E7C5B87AD7E108B27CF1DBF7A1CFED04AB700FB3CF36B5",
    "previousIssuer" => "4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m",
    "inner_hash" => "D6617F43EC29E34B71AB9ADFFAA929E59C2FA3D3BF58F2E26B5D8DBB4271009B",
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
        "locktime" => 0,
        "hash" => "676D38DA93A4071729CFB85B077C8D753037C822A7A842354DD554873A42D7D4",
        "blockstamp" => "100001-00000273D97983AA983A5E179AC5F02B40A2E9AE2BA45C980EDC35D885FC4AFF",
        "blockstampTime" => 0,
        "issuers" => [
          "4h6X2zW8jLcpxwcb8m6K5X5rSsok68oobn1gwy4dc5yK",
          "DYiFWnPsQyp8kmPSPVcfLjRzKHUJK8WtBKLJmGJN9MXk"
        ],
        "inputs" => [
          "220100:0:T:B708270B661161DA6A8CF68B7B80895864CAA991F9CABD8D4A06D68CAE7C1DBE:33"
        ],
        "outputs" => [
          "90:0:SIG(2ZPiZZLKsUitStqyv28e4cipchxDQiPZxEYNN6xmqxJx)"
        ],
        "unlocks" => [
          "0:SIG(0)"
        ],
        "signatures" => [
          "/P8bS0BNI0ZpbE7PEsF7KwNGbJd9u2nJcGE8Qggl6u4JngI8VjuW+bVvY3r14PssxAgT6vJ3iHqd32BNol0kAw==",
          "VIrXNDBnFgz+1g9Ksj2Vb8p7QHEEQN2DhzQx83FEL6bWbY5NsxZwOv4QoqDdi4ZH9bevQj/sxlGCukZuJEYkCA=="
        ],
        "comment" => "REMU:99501:100000"
      },
      %{
        "version" => 10,
        "currency" => "g1",
        "locktime" => 0,
        "hash" => "676D38DA93A4071729CFB85B077C8D753037C822A7A842354DD554873A42D7D4",
        "blockstamp" => "100001-00000273D97983AA983A5E179AC5F02B40A2E9AE2BA45C980EDC35D885FC4AFF",
        "blockstampTime" => 0,
        "issuers" => [
          "4h6X2zW8jLcpxwcb8m6K5X5rSsok68oobn1gwy4dc5yK",
          "DYiFWnPsQyp8kmPSPVcfLjRzKHUJK8WtBKLJmGJN9MXk"
        ],
        "inputs" => [
          "220100:0:T:B708270B661161DA6A8CF68B7B80895864CAA991F9CABD8D4A06D68CAE7C1DBE:33"
        ],
        "outputs" => [
          "90:0:SIG(2ZPiZZLKsUitStqyv28e4cipchxDQiPZxEYNN6xmqxJx)"
        ],
        "unlocks" => [
          "0:SIG(0)"
        ],
        "signatures" => [
          "VIrXNDBnFgz+1g9Ksj2Vb8p7QHEEQN2DhzQx83FEL6bWbY5NsxZwOv4QoqDdi4ZH9bevQj/sxlGCukZuJEYkCA==",
          "/P8bS0BNI0ZpbE7PEsF7KwNGbJd9u2nJcGE8Qggl6u4JngI8VjuW+bVvY3r14PssxAgT6vJ3iHqd32BNol0kAw=="
        ],
        "comment" => "REMU:99501:100000"
      }
    ],
    "raw" =>
      "Version: 10\nType: Block\nCurrency: g1\nNumber: 100003\nPoWMin: 85\nTime: 1520199092\nMedianTime: 1520196079\nUnitBase: 0\nIssuer: DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ\nIssuersFrame: 164\nIssuersFrameVar: 2\nDifferentIssuersCount: 33\nPreviousHash: 0000068D8D2ABEB0A4E7C5B87AD7E108B27CF1DBF7A1CFED04AB700FB3CF36B5\nPreviousIssuer: 4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m\nMembersCount: 778\nIdentities:\nJoiners:\nActives:\nLeavers:\nRevoked:\nExcluded:\nCertifications:\nTransactions:\nTX:10:1:3:3:39:1:0\n100001-00000273D97983AA983A5E179AC5F02B40A2E9AE2BA45C980EDC35D885FC4AFF\nTENGx7WtzFsTXwnbrPEvb6odX2WnqYcnnrjiiLvp1mS\n220100:0:T:B708270B661161DA6A8CF68B7B80895864CAA991F9CABD8D4A06D68CAE7C1DBE:33\n10000:0:T:FDB0C5E8318D4253205BB75FDFAEF259A802124FEC1AD3794D525F7951D85658:0\n20020:0:T:EC09188639DC8125FB30B2B8B9BE733F8AE267CA6AEE5466075B940B64E59592:0\n0:SIG(0)\n1:SIG(0)\n2:SIG(0)\n90:0:SIG(2ZPiZZLKsUitStqyv28e4cipchxDQiPZxEYNN6xmqxJx)\n135:0:SIG(98wvdsHGnnNDczKMp6FM9KUuPRBTwn77PN4x6EC6i9KN)\n105:0:SIG(FVUFRrk1K5TQGsY7PRLwqHgdHRoHrwb1hcucp4C2N5tD)\n190:0:SIG(GRBPV3Y7PQnB9LaZhSGuS3BqBJbSHyibzYq65kTh1nQ4)\n120:0:SIG(6fFt4zdvtNyVcfJn7Y41mKLmMDizyK3nVeNW3qdDXzpc)\n155:0:SIG(DA4PYtXdvQqk1nCaprXH52iMsK5Ahxs1nRWbWKLhpVkQ)\n130:0:SIG(4fHMTFBMo5sTQEc5p1CNWz28S4mnnqdUBmECq1zt4n2m)\n160:0:SIG(D9D2zaJoWYWveii1JRYLVK3J4Z7ZH3QczoKrnQeiM6mx)\n155:0:SIG(38MEAZN68Pz1DTvT3tqgxx4yQP6snJCQhPqEFxbDk4aE)\n105:0:SIG(CV1GNhPpVisWZMe3THGnGLca5KkyfbTra5UgkFgKUJTm)\n85:0:SIG(FSAPnBZidfUaiURd1qxwmx4z5VGEPvYfthWfq5vfwGFB)\n80:0:SIG(4GX5gUFwKg8Y8oL5ZFwFD64U3vEJo6CtY61Y3J8LMCHk)\n70:0:SIG(CRBxCJrTA6tmHsgt9cQh9SHcCc8w8q95YTp38CPHx2Uk)\n15:0:SIG(3wdDzBz18mWupx1UChMnhky2Nut3XVnyn9U7Y662J7yE)\n85:0:SIG(81t4UcqmrVnRqGaQwc2zSmoe1bM5G4vQ7fPxbTeD8a5X)\n45:0:SIG(7AQzQb475tEzCkSLKD4HffeQbckizJWFvubhYA2rfwgt)\n100:0:SIG(GfKERHnJTYzKhKUma5h1uWhetbA8yHKymhVH2raf2aCP)\n60:0:SIG(5kpscasQx9p45TXJxtGV17G1Fw9URmMeqouz3x8FNYpB)\n25:0:SIG(6FqjGokAhv6rfXZSmiZs4u9CBJqTFtLZNQXE7Qw2RTNZ)\n85:0:SIG(2ny7YAdmzReQxAayyJZsyVYwYhVyax2thKcGknmQy5nQ)\n20:0:SIG(5cnvo5bmR8QbtyNVnkDXWq6n5My6oNLd1o6auJApGCsv)\n35:0:SIG(HbTqJ1Ts3RhJ8Rx4XkNyh1oSKmoZL1kY5U7t9mKTSjAB)\n95:0:SIG(2sZF6j2PkxBDNAqUde7Dgo5x3crkerZpQ4rBqqJGn8QT)\n10:0:SIG(4bD7J3uA5pH2N9Xqimspf2XxWN4ESM2Az2XBqtSeHvUZ)\n60:0:SIG(5gJYnQp8v7bWwk7EWRoL8vCLof1r3y9c6VDdnGSM1GLv)\n30:0:SIG(Hxvt6Yj6n7sYud5YCiH6z4NJT4mbuSjBqErVX4V8GE3)\n45:0:SIG(AmDcZSEB5MCt8GyZ1VMRt1sUwRH5D7HpXx8YKhMKZ1qa)\n15:0:SIG(7G2mS5aCoT4jCL5WfLKQsXfMJaV9d3jVGUGnwq6Tg36J)\n40:0:SIG(7vU9BMDhN6fBuRa2iK3JRbC6pqQKb4qDMGsFcQuT5cz)\n15:0:SIG(Be1eVp7etVfA7cT6er6dcJ9d5KxGJVY2tzCGGCAz3yG)\n50:0:SIG(5dzkzedBWdeqTFCaD7AkKPMPusfRUL1XyFNJWWGYQ9f1)\n15:0:SIG(D3krfq6J9AmfpKnS3gQVYoy7NzGCc61vokteTS8LJ4YH)\n5:0:SIG(92VdBcvvCWVBc79kNHpqLceiyPuCxrCwNx1zLacsVy2L)\n30:0:SIG(9zCYjVtPFzqjuQ3d1vY1FuHhpEuRpafXkiEpwE3RypN1)\n5:0:SIG(FEkbc4BfJukSWnCU6Hed6dgwwTuPFTVdgz5LpL4iHr9J)\n10:0:SIG(9toSKwQayx462ye94gtJ4JJh69k2KAWfmzjK6kNZBLph)\n20:0:SIG(EwXXo4YAG6BuNhifNZrMKAXNDXcYDhFWaZcSu5iZnSUX)\n5:0:SIG(9UuWHs3ZDvV4EiViDGf2zJKNUa8V2ot7hH2zPD1C1sj1)\n247620:0:SIG(TENGx7WtzFsTXwnbrPEvb6odX2WnqYcnnrjiiLvp1mS)\nREMU:99501:100000\nnnQLYOsiXa9fqy7dHTm1gA+Wwru3MJl6nSBrUWBOlSS9RLg3rTFYA42ClTNXt55QJKr7cUP9caZeJRl8BHAoAQ==\nInnerHash: D6617F43EC29E34B71AB9ADFFAA929E59C2FA3D3BF58F2E26B5D8DBB4271009B\nNonce: 10700000025540\n"
  }

  test "validates the transactions have issuer signatures in order" do
    assert TxSigOrdered.valid(@one_issuer_correct)
    assert TxSigOrdered.valid(@two_tx_correct)
    refute TxSigOrdered.valid(@one_issuer_bad_sig)
    refute TxSigOrdered.valid(@two_issuers_wrong_order)
    refute TxSigOrdered.valid(@two_tx_one_wrong)
    assert TxSigOrdered.valid(@two_issuers_correct)
  end
end
