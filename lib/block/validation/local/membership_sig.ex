defmodule Block.Validation.Local.MembershipSig do

  # Reference material: https://git.duniter.org/nodes/typescript/duniter/-/blob/dev/app/lib/dto/MembershipDTO.ts#L118-1341
  def fromInline(inlineMS, type, currency) do
    [issuer, sig, blockstamp, certts, userid] = String.split(inlineMS, ":")
    [
      version: 10,
      currency: currency,
      issuer: issuer,
      type: type,
      blockstamp: blockstamp,
      userid: userid,
      certts: certts,
      sig: sig
    ]
  end

  # Reference material: https://git.duniter.org/nodes/typescript/duniter/-/blob/dev/app/lib/dto/MembershipDTO.ts#L86-97
  def asRaw(kwlist) do
    "Version: " <> Integer.to_string(kwlist[:version]) <> "\n" <>
    "Type: Membership\n" <>
    "Currency: " <> kwlist[:currency] <> "\n" <>
    "Issuer: " <> kwlist[:issuer] <> "\n" <>
    "Block: " <> kwlist[:blockstamp] <> "\n" <>
    "Membership: " <> kwlist[:type] <> "\n" <>
    "UserID: " <> kwlist[:userid] <> "\n" <>
    "CertTS: " <> kwlist[:certts] <> "\n"
  end

  def checkSingleMembershipSig(member, currency) do
    kwlist = fromInline(member, "IN", currency)
    Crypto.verify_digital_signature(kwlist[:sig], asRaw(kwlist), kwlist[:issuer])
  end

  def checkMembershipsSig([], _currency) do
    true
  end

  def checkMembershipsSig(members, currency) do
    checkSingleMembershipSig(hd(members), currency) and checkMembershipsSig(tl(members), currency)
  end

  def valid(block) do
    checkMembershipsSig(block["joiners"], block["currency"])
  end
end
