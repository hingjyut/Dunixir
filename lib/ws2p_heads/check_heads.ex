defmodule WS2P.CheckHeads do

  def api_regexp() do
    "WS2P(" <> Constants.ws2p_private_prefix_regexp() <>
    ")?(" <> Constants.ws2p_public_prefix_regexp() <> ")?"
  end

  def head_v0_regexp() do
    api_regexp() <> ":" <> Constants.ws2p_head_regexp() <> ":"<> Constants.pubkey_regexp()
    <> ":"<> Constants.block_uid_regexp()
  end

  def rest_head_v1_regexpr() do
    Constants.ws2pid_regexp() <> ":" <> Constants.software() <> ":" <>
    Constants.software_version() <> ":" <> Constants.pow_prefix()
  end

  def check_head_v0(%{message: message, sig: sig}) do
    completed_regexp = head_v0_regexp() <> "(?::)?(.*)"
    is_message_valid = Regex.compile!(completed_regexp) |> Regex.match?(message)
    is_sig_valid = Regex.compile!(Constants.signature_regexp()) |> Regex.match?(sig)
    is_message_valid and is_sig_valid
  end


  def check_head_v1(%{message: message, sig: sig}) do
    completed_regexp = head_v0_regexp() <> ":" <> rest_head_v1_regexpr() <> "(?::)?(.*)"
    is_message_valid = Regex.compile!(completed_regexp) |> Regex.match?(message)
    is_sig_valid = Regex.compile!(Constants.signature_regexp()) |> Regex.match?(sig)
    is_message_valid and is_sig_valid
  end

  def check_head_v2(%{messageV2: message, sigV2: sig}) do
    completed_regexp = head_v0_regexp() <> ":" <> rest_head_v1_regexpr() <> ":"
      <> Constants.free_member_room() <> ":" <> Constants.free_mirror_room() <>"(?::)?(.*)"
    is_message_valid = Regex.compile!(completed_regexp) |> Regex.match?(message)
    is_sig_valid = Regex.compile!(Constants.signature_regexp()) |> Regex.match?(sig)
    is_message_valid and is_sig_valid
  end

end
