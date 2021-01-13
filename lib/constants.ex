defmodule Constants do
  @moduledoc """
  A module contains all constants

  """

  def free_member_room, do: "[0-9]+"
  def free_mirror_room, do: "[0-9]+"
  def software, do: "[A-Za-z-_]+"
  def software_version, do: "[0-9]+[.][0-9]+[.][0-9]+[-\\w]*"
  def pow_prefix, do: "[0-9]+"
  def ws2p_regexp, do: "WS2P (?:[1-9][0-9]* )?([a-f0-9]{8}) ([a-z_][a-z0-9-_.]*|[0-9.]+|[0-9a-f:]+) ([0-9]+)(?: (.+))?"
  def ws2p_v2_regexp, do: "WS2P ([1-9][0-9]*) ([a-f0-9]{8}) ([a-z_][a-z0-9-_.]*|[0-9.]+|[0-9a-f:]+) ([0-9]+)(?: (.+))?"
  def ws2ptor_regexp, do: "WS2PTOR (?:[1-9][0-9]* )?([a-f0-9]{8}) ([a-z0-9-_.]*|[0-9.]+|[0-9a-f:]+.onion) ([0-9]+)(?: (.+))?"
  def ws2ptor_v2_regexp, do: "WS2PTOR ([1-9][0-9]*) ([a-f0-9]{8}) ([a-z0-9-_.]*|[0-9.]+|[0-9a-f:]+.onion) ([0-9]+)(?: (.+))?"
  def ws_full_address_onion_regex, do: "(?:wss?:\/\/)(?:www\.)?([0-9a-z]{16}\.onion)(:[0-9]+)?"
  def uid_regexp, do: "[A-Za-z0-9_-]{2,100}$"
  def pubkey_regexp, do: "(?![OIl])[1-9A-Za-z]{42,45}"
  def signature_regexp, do: "[A-Za-z0-9+/]+(?:=|==)?"
  def block_hash_regexp, do: "[0-9a-fA-F]{5,64}"
  def transaction_hash_regexp, do: "[0-9a-fA-F]{5,64}"
  def hash_regexp, do: "[A-F0-9]{64}"
  def block_id_regexp, do: "[0-9]+"
  def block_uid_regexp, do: block_id_regexp() <> "-" <> block_hash_regexp()
  def conditions_regexp() do
     "(&&|\\|\\|| |[()]|(SIG\\(" <> pubkey_regexp() <> "\\)|(XHX\\("
     <> hash_regexp() <> "\\))))*"
  end
  def host_regexp, do: "[a-z0-9-_.]*(?:.[a-zA-Z])?"
  def path_regexp, do: "[/\\w \\.-]*/?"
  def ws2pid_regexp, do: "[0-9a-f]{8}"
  def ws2p_private_prefix_regexp, do: "O[CT][SAM]"
  def ws2p_public_prefix_regexp, do: "I[CT]"
  def ws2p_head_regexp, do: "HEAD:?(?:[0-9]+)?"
  def empty_hash, do: "E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855"
  def endpoint_flags_regexp, do: "[S]"

end
