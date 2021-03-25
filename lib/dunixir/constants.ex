defmodule Constants do
  def version, do: "1.0"
  def forkWindowSize, do: 10
  def sandboxTxSize, do: 200
  def sandboxIdSize, do: 5000
  def sandboxMemberSize, do: 5000
  def medianTime, do: 10
  def msValidity, do: 10
  def msPeriod, do: 10
  def sigValidity, do: 10
  def sigPeriod, do: 10
  def sigReplay, do: 10
  def nbDigitsUD, do: 4

  def powDifficultyRangeRatio, do: 1.189



  def head_v0_regexp, do: "^WS2P:HEAD:(" <> pubkey_regexp() <> "):(" <> block_uid_regexp() <> ")$"

  def head_v1_regexp() do
    "^WS2P(?:O[CT][SAM]?)?(?:I[CT])?:HEAD:1:(" <>
      pubkey_regexp() <>
      "):(" <>
      block_uid_regexp() <>
      "):(" <>
      ws2pid_regexp() <>
      "):(" <>
      software() <> "):(" <> software_version() <> "):(" <> zero_or_positive_int() <> ")$"
  end

  def head_v2_regexp() do
    "^WS2P(?:O[CT][SAM]?)?(?:I[CT])?:HEAD:2:(" <>
      pubkey_regexp() <>
      "):(" <>
      block_uid_regexp() <>
      "):(" <>
      ws2pid_regexp() <>
      "):(" <>
      software() <>
      "):(" <>
      software_version() <>
      "):(" <>
      zero_or_positive_int() <>
      "):(" <>
      zero_or_positive_int() <>
      "):(" <> zero_or_positive_int() <> ")(?::" <> timestamp() <> ")?$"
  end

  def timestamp, do: "[1-9][0-9]{0,18}"
  def zero_or_positive_int, do: "0|[1-9][0-9]{0,18}"
  def software, do: "[A-Za-z-_]+"
  def software_version, do: "[0-9]+[.][0-9]+[.][0-9]+[-\\w]*"

  def ws2p_regexp() do
    "WS2P (?:[1-9][0-9]* )?([a-f0-9]{8}) ([a-z_][a-z0-9-_.]*|[0-9.]+|[0-9a-f:]+) ([0-9]+)(?: (.+))?"
  end

  def ws2p_v2_regexp() do
    "WS2P ([1-9][0-9]*) ([a-f0-9]{8}) ([a-z_][a-z0-9-_.]*|[0-9.]+|[0-9a-f:]+) ([0-9]+)(?: (.+))?"
  end

  def ws2ptor_regexp() do
    "WS2PTOR (?:[1-9][0-9]* )?([a-f0-9]{8}) ([a-z0-9-_.]*|[0-9.]+|[0-9a-f:]+.onion) ([0-9]+)(?: (.+))?"
  end

  def ws2ptor_v2_regexp() do
    "WS2PTOR ([1-9][0-9]*) ([a-f0-9]{8}) ([a-z0-9-_.]*|[0-9.]+|[0-9a-f:]+.onion) ([0-9]+)(?: (.+))?"
  end

  def ws_full_address_onion_regex, do: "(?:wss?:\/\/)(?:www\.)?([0-9a-z]{16}\.onion)(:[0-9]+)?"
  def uid_regexp, do: "[A-Za-z0-9_-]{2,100}$"
  def pubkey_regexp, do: "(?![OIl])[1-9A-Za-z]{42,45}"
  def signature_regexp, do: "[A-Za-z0-9+\\/=]{87,88}"
  def block_hash_regexp, do: "[0-9a-fA-F]{5,64}"
  def transaction_hash_regexp, do: "[0-9a-fA-F]{5,64}"
  def hash_regexp, do: "[A-F0-9]{64}"
  def block_id_regexp, do: "[0-9]+"
  def block_uid_regexp, do: "(" <> block_id_regexp() <> ")-(" <> block_hash_regexp() <> ")"

  def conditions_regexp() do
    "(&&|\\|\\|| |[()]|(SIG\\(" <>
      pubkey_regexp() <>
      "\\)|(XHX\\(" <>
      hash_regexp() <> "\\))))*"
  end

  def host_regexp, do: "[a-z0-9-_.]*(?:.[a-zA-Z])?"
  def path_regexp, do: "[/\\w \\.-]*/?"
  def ws2pid_regexp, do: "[0-9a-f]{8}"
  def ws2p_private_prefix_regexp, do: "O[CT][SAM]"
  def ws2p_public_prefix_regexp, do: "I[CT]"
  def ws2p_head_regexp, do: "HEAD:?(?:[0-9]+)?"
  def empty_hash, do: "E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855"
  def endpoint_flags_regexp, do: "[S]"

  def ipv4_regexp() do
    "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}" <>
      "([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"
  end

  def ipv6_regexp() do
    "^((([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}:" <>
      "[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){5}:" <>
      "([0-9A-Fa-f]{1,4}:)?[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){4}:" <>
      "([0-9A-Fa-f]{1,4}:){0,2}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){3}:" <>
      "([0-9A-Fa-f]{1,4}:){0,3}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){2}: " <>
      "([0-9A-Fa-f]{1,4}:){0,4}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}" <>
      "((b((25[0-5])|(1d{2})|(2[0-4]d)|(d{1,2}))b).){3}(b((25[0-5])|(1d{2})|(2[0-4]d)|(d{1,2}))b))|" <>
      "(([0-9A-Fa-f]{1,4}:){0,5}:((b((25[0-5])|(1d{2})|(2[0-4]d)|(d{1,2}))b).){3}(b((25[0-5])|(1d{2})|" <>
      "(2[0-4]d)|(d{1,2}))b))|(::([0-9A-Fa-f]{1,4}:){0,5}((b((25[0-5])|(1d{2})|(2[0-4]d)|(d{1,2}))b).){3}" <>
      "(b((25[0-5])|(1d{2})|(2[0-4]d)|(d{1,2}))b))|" <>
      "([0-9A-Fa-f]{1,4}::([0-9A-Fa-f]{1,4}:){0,5}[0-9A-Fa-f]{1,4})|" <>
      "(::([0-9A-Fa-f]{1,4}:){0,6}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){1,7}:))$"
  end

end

defmodule Constants.Contract do
  def c, do: 0.007376575
  def dt, do: 30.4375 * 24 * 3600
  def dtReeval, do: 30.4375 * 24 * 3600
  def ud0, do: 100
  def stepMax, do: 3
  def msValidity, do: 3600 * 24 * 365
  def sigValidity, do: 3600 * 24 * 365
  def sigPeriod, do: 0
  def sigReplay, do: 0
  def sigWindow, do: 3600 * 24 * 7
  def sigQty, do: 5
  def xpercent, do: 0.9
  def percentRot, do: 2/3
  def powDelay, do: 0
  def avgGenTime, do: 16 * 60
  def dtDiffEval, do: 10
  def medianTimeBlocks, do: 20
  def forSize, do: 100
  def switchOnHeadAdvance, do: 3
  def nonWoTPeersLimit, do: 100
  def txsMempoolSize, do: 200
  def sigStock, do: 40
  def idtyWindow, do: 3600 * 24 * 7
  def msWindow, do: 3600 * 24 * 7
end

defmodule Constants.PoW do
  def cpu, do: 0.6
  def prefix, do: 1

end
