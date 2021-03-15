defmodule Block.Validation.Local.BlockSignature do
  require Logger

  def invalid_g1_block() do
    [
      15144,
      31202,
      85448,
      87566,
      90830,
      109_327,
      189_835,
      199_172,
      221_274,
      253_582
    ]
  end

  def invalid_gt_blocks() do
    [
      24316,
      62067,
      62551,
      93288,
      173_118,
      183_706,
      196_196,
      246_027,
      247_211,
      263_207,
      307_038,
      328_741,
      335_914,
      377_316,
      395_714,
      396_024,
      407_913,
      422_366,
      496_751
    ]
  end

  @doc """
  check if block signature is valid
  """
  def valid(block) do
    # Historically, Duniter used a buggy version of TweetNaCl (see duniter #1390)
    # Starting with the v12 blocks, Duniter uses a fixed version of TweetNaCl.
    signed_part = get_signed_part(block["inner_hash"], to_string(block["nonce"]))

    cond do
      Crypto.verify_digital_signature(block["signature"], signed_part, block["issuer"]) ->
        true

      (block["version"] < 12 and block["currency"] === "G1" and
         Enum.member?(invalid_g1_block(), block["number"])) or
          (block["version"] < 12 and block["currency"] === "GT" and
             Enum.member?(invalid_gt_blocks(), block["number"])) ->
        true

      true ->
        Logger.error("Block's signature must match")
        false
    end

    # if Crypto.verify_digital_signature(block["signature"], signed_part, block["issuer"]) do
    #   true
    # else
    #   # If DUBP < v12, block may have invalid signature
    #   if (block["version"] < 12 and block["currency"] === "G1" and
    #         Enum.member?(invalid_g1_block(), block["number"])) or
    #        (block["version"] < 12 and block["currency"] === "GT" and
    #           Enum.member?(invalid_gt_blocks(), block["number"])) do
    #     true
    #   else
    #     Logger.error("Block's signature must match")
    #     false
    #   end
    # end
  end

  defp get_signed_part(inner_hash, nonce) do
    "InnerHash: " <> inner_hash <> "\n" <> "Nonce: " <> nonce <> "\n"
  end
end
