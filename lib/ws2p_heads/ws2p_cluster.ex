defmodule WS2P.Cluster do
  # use GenServer
  require Logger

  # def start_link(head_cache_id) do
  #   GenServer.start_link(__MODULE__, {:create, head_cache_id},
  #     name: {:via, Registry, {WS2P.HeadCache.Registry, head_cache_id}}
  #   )
  # end

  # def init({:create, head_cache_id}) do
  #   table = :ets.new(head_cache_id, [:set, :protected])
  #   {:ok, table}
  # end

  @spec get_full_address(binary, binary, any) :: <<_::8, _::_*8>>
  @doc """
  get a wss:// address or ws:// addresss

  Status: completed
  """
  def get_full_address(host, port, path) do
    host =
      if Regex.compile!(Constants.ipv6_regexp()) |> Regex.match?(host), do: "[" <> host <> "]"

    # Make the path be a string and delete the space at the beginning of the path
    path = to_string(path) |> String.trim()
    # Check that the path starts well with / (added if not)
    path =
      if String.length(path) > 0 and not (Regex.compile!("^\/") |> Regex.match?(path)),
        do: "/" <> path

    # Choose the web protocol depending on the port
    protocol = if port == 433, do: "wss://", else: "ws://"

    protocol <> host <> ":" <> port <> path
  end

  def get_known_heads() do
    #TODO: initialize my personal head, put it in cache ()
    #TODO: loop headcache to get all heads
  end

  def heads_received(heads) do
    modified_headscache = Enum.map(heads, fn x -> deal_head(x) end)
    modified_headscache
  end

  @doc """
  A middle function serves for heads_received

  Status: completed
  """
  @spec deal_head(WS2PHead.t()) :: WS2PHeadCache.t()
  def deal_head(head) do
    cond do
      Regex.compile!(Constants.signature_regexp()) |> Regex.match?(head.sigV2) ->
        # if matches head_v2_regexp
        if Regex.compile!(Constants.head_v2_regexp()) |> Regex.match?(head.messageV2) do
          [
            _,
            _,
            _,
            pubkey,
            blockstamp,
            ws2pid,
            _,
            _,
            _,
            _,
            _
          ] = String.split(head.messageV2, ":")

          head_received(head, pubkey, pubkey <> "-" <> ws2pid, blockstamp)
        else
          Logger.error("Head_V2_Wrong_Format")
        end

      Regex.compile!(Constants.signature_regexp()) |> Regex.match?(head.sig) ->
        cond do
          Regex.compile!(Constants.head_v1_regexp()) |> Regex.match?(head.message) ->
            [
              _api,
              _head,
              _version,
              pubkey,
              blockstamp,
              ws2pid,
              _software,
              _soft_version,
              _pow_prefix
            ] = String.split(head.message, ":")

            head_received(head, pubkey, pubkey <> "-" <> ws2pid, blockstamp)

          Regex.compile!(Constants.head_v0_regexp()) |> Regex.match?(head.message) ->
            [
              _api,
              _head,
              pubkey,
              blockstamp
            ] = String.split(head.message, ":")

            head_received(head, pubkey, pubkey <> "-" <> "00000000", blockstamp)

          true ->
            Logger.error("Head_V1 or Head_V0 Wrong Format")
        end

      true ->
        Logger.error("Head Message Wrong Signed")
    end
  end

  @doc """
  Deal with each received head, if current head is valid, save it into headcache
  return this headcache, so that we can broadcast heads later

  Status: ongoing
  """
  @spec head_received(
          WS2PHead.t(),
          String.t(),
          String.t(),
          String.t()
        ) :: WS2PHeadCache.t()
  def head_received(head, pubkey, full_id, blockstamp) do
    # Prevent fields injection
    # TODO: add and (!h.step || h.step.toFixed(0).match(/^[0-9]*$/))
    if (Regex.compile!(Constants.head_v0_regexp()) |> Regex.match?(head.message) or
          Regex.compile!(Constants.head_v1_regexp()) |> Regex.match?(head.message)) and
         Regex.compile!(Constants.signature_regexp()) |> Regex.match?(head.sig) and
         (not head.messageV2 or
            Regex.compile!(Constants.head_v2_regexp()) |> Regex.match?(head.messageV2)) and
         (not head.sigV2 or
            Regex.compile!(Constants.signature_regexp()) |> Regex.match?(head.sigV2)) do
      sig_ok = Crypto.verify_digital_signature(head.sig, head.message, pubkey)
      sigV2_ok = Crypto.verify_digital_signature(head.sigV2, head.messageV2, pubkey)

      if (sig_ok and sigV2_ok) or sig_ok do
        headcache = GenServer.call(WS2P.HeadsCache, :get_headcache)
        step = if headcache[full_id]["step"] != nil, do: headcache[full_id]["step"], else: 0
        # more recent head
        # closer head
        if Integer.parse(headcache[full_id][blockstamp]) < Integer.parse(blockstamp) or
             (head["step"] < step and headcache[full_id][blockstamp] == blockstamp) do
          # TODO: If the head pubkey is not a member, make sure there is an active ws2p connection with this pubkey.
          # TODO: check if pubkey is ourself? if pubkey is a member, if pubkey is one of our connected points
          is_allowed = true
          is_block_existed = true

          if is_allowed and is_block_existed do
            Map.put(headcache[full_id], "blockstamp", blockstamp)
            Map.put(headcache[full_id], "message", head["message"])
            Map.put(headcache[full_id], "sig", head["sig"])
            Map.put(headcache[full_id], "messageV2", head["messageV2"])
            Map.put(headcache[full_id], "sigV2", head["sigV2"])
            Map.put(headcache[full_id], "step", step)
            headcache[full_id]
          end
        end
      else
        Logger.error("Head Message Wrongly Signed")
      end
    else
      Logger.error("Head Wrong Format")
    end
  end
end

defmodule WS2PHead do
  @type t() :: %{
          message: String.t(),
          messageV2: String.t(),
          sig: String.t(),
          sigV2: String.t(),
          step: String.t()
        }
end

defmodule WS2PHeadCache do
  @type t() :: %{
          blockstamp: String.t(),
          message: String.t(),
          sig: String.t(),
          messageV2: String.t(),
          sigV2: String.t(),
          step: String.t()
        }
end
