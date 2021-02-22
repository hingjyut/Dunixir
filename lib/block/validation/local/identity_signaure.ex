defmodule Block.Validation.Local.IdentitySignature do
  require Logger

  @default_document_version 10
  def valid(block) do
    identities = block["identities"]
    not is_wrong_sig(identities, block["currency"])
  end

  defp is_wrong_sig(identities, currency) do
    case length(identities) do
      0 ->
        false
      _ ->
        [identity | tail] = identities
        [pubkey, sig, buid, uid] = String.split(identity, ":")

        idty = %{
          "version" => @default_document_version,
          "currency" => currency,
          "pubkey" => pubkey,
          "sig" => sig,
          "buid" => buid,
          "uid" => uid
        }

        if not Crypto.verify_digital_signature(sig, get_idty_raw_without_sig(idty), pubkey) do
          Logger.error("Identity's signature must match")
          true
        else
          is_wrong_sig(tail, currency)
        end
    end
  end

  defp get_idty_raw_without_sig(identity) do
    "" <>
      "Version: " <>
      to_string(identity["version"]) <>
      "\n" <>
      "Type: Identity\n" <>
      "Currency: " <>
      identity["currency"] <>
      "\n" <>
      "Issuer: " <>
      identity["pubkey"] <>
      "\n" <>
      "UniqueID: " <>
      identity["uid"] <>
      "\n" <>
      "Timestamp: " <> identity["buid"] <> "\n"
  end
end
