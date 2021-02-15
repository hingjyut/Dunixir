defmodule WS2P.Cluster do
  use GenServer
  require Logger

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], [])
  end

  def init(_args) do
    # initial heads_cache is an empty map
    {:ok,
     %{
       "heads_cache" => %{},
       "member_keys_cache" => %{},
       "blockstamp_cache" => %{},
       "new_heads_cache" => %{}
     }}
  end

  def handle_call(:get_current_state, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:heads_received, heads}, _from, ws2p_cache) do
    # for each head, call head_verification
    IO.puts("I'm in heads_received")
    already_formed_heads = Enum.map(heads, fn x -> formed_heads(x) end)
    updated_ws2p_cache = head_verification(already_formed_heads, ws2p_cache)

    # veriify if all heads in heads_cache are valid, if they are, saved the new state and broadcast heads_cache
    if map_size(updated_ws2p_cache) != 0 do
      %{
        "heads_cache" => _heads_cache,
        "member_keys_cache" => _member_keys_cache,
        "blockstamp_cache" => _blockstamp_cache,
        "new_heads_cache" => new_heads_cache,
      } = updated_ws2p_cache

      if map_size(new_heads_cache) == length(heads) and not Enum.member?(new_heads_cache, nil) do
        # put new_heads_cache's value to heads_cache and empty new_heads_cache
        updated_ws2p_cache = Map.put(updated_ws2p_cache, "heads_cache", new_heads_cache)
        updated_ws2p_cache = Map.put(updated_ws2p_cache, "new_heads_cache", %{})
        # IO.inspect(updated_ws2p_cache)
        {:reply, updated_ws2p_cache["heads_cache"], updated_ws2p_cache}
      else
        Logger.info("There is invalid head, shouldn't broadscast these heads")
      end
    else
      Logger.error("There is invalid head, shouldn't broadscast these heads")
      {:reply, ws2p_cache, ws2p_cache}
    end
  end

  # This function returns %{pubkey <> "-" <> ws2pid, WS2PHeadCache.t()}
  defp formed_heads(head) do
    IO.puts("I'm in formed_received")

    cond do
      Regex.compile!(Constants.head_v2_regexp()) |> Regex.match?(head["messageV2"]) ->
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
        ] = String.split(head["messageV2"], ":")

        IO.puts("let's go to head verification, V2")
        # IO.inspect([head, pubkey, pubkey <> "-" <> ws2pid, blockstamp])
        [head, pubkey, pubkey <> "-" <> ws2pid, blockstamp]

      # head_verification(head, pubkey, pubkey <> "-" <> ws2pid, blockstamp, ws2p_cache)

      Regex.compile!(Constants.head_v1_regexp()) |> Regex.match?(head["message"]) ->
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
        ] = String.split(head["message"], ":")

        # Map.put(head, :blockstamp, blockstamp)
        IO.puts("let's go to head verification")
        [head, pubkey, pubkey <> "-" <> ws2pid, blockstamp]

      # head_verification(head, pubkey, pubkey <> "-" <> ws2pid, blockstamp, ws2p_cache)

      Regex.compile!(Constants.head_v0_regexp()) |> Regex.match?(head["message"]) ->
        [
          _api,
          _head,
          pubkey,
          blockstamp
        ] = String.split(head["message"], ":")

        # Map.put(head, :blockstamp, blockstamp)
        [head, pubkey, pubkey <> "-" <> "000000", blockstamp]
        # head_verification(head, pubkey, pubkey <> "-" <> "000000", blockstamp, ws2p_cache)
    end
  end

  def head_verification(
        all_formed_heads,
        ws2p_cache = %{
          "heads_cache" => heads_cache,
          "member_keys_cache" => member_keys_cache,
          "blockstamp_cache" => blockstamp_cache,
          "new_heads_cache" => new_heads_cache
        }
      ) do
    if length(all_formed_heads) == 0 do
      IO.puts("Stop me")
      # IO.inspect(ws2p_cache)
      ws2p_cache
    else
      [current_head | current_tail] = all_formed_heads
      [head, pubkey, full_id, blockstamp] = current_head
      # if current head is not in headscache, check it and add it into cache
      if (Regex.compile!(Constants.head_v0_regexp()) |> Regex.match?(head["message"]) or
            Regex.compile!(Constants.head_v1_regexp()) |> Regex.match?(head["message"])) and
           Regex.compile!(Constants.signature_regexp()) |> Regex.match?(head["sig"]) and
           Regex.compile!(Constants.head_v2_regexp()) |> Regex.match?(head["messageV2"]) and
           Regex.compile!(Constants.signature_regexp()) |> Regex.match?(head["sigV2"]) and
           Regex.compile!(Constants.zero_or_positive_int())
           |> Regex.match?(to_string(head["step"])) do
        sig_ok = Crypto.verify_digital_signature(head["sig"], head["message"], pubkey)
        sigV2_ok = Crypto.verify_digital_signature(head["sigV2"], head["messageV2"], pubkey)
        IO.puts("passed regex verification")

        if (sig_ok and sigV2_ok) or sig_ok do
          IO.puts("signatures are valid")

          step = if heads_cache[full_id]["step"] != nil, do: heads_cache[full_id]["step"], else: 0

          if heads_cache[full_id] == nil or
               Integer.parse(heads_cache[full_id]["blockstamp"]) < Integer.parse(blockstamp) or
               (head["step"] != nil and head["step"] < step and
                  heads_cache[full_id]["blockstamp"] == blockstamp) do
            # Check that issuer is a member and the block exists
            server_pubkey = "BhQf2fkGAe1EszyZRJqasMr23YLSf1P3mhuYzEoKpgVA"

            # Check if pubkey exists
            # TODO: searched key in connected key
            if server_pubkey || is_member_key(member_keys_cache, pubkey) do
              # if current pubkey exists, put it into member keys cache

              member_keys_cache = Map.put(member_keys_cache, pubkey, :os.system_time())
              ws2p_cache = Map.put(ws2p_cache, "member_keys_cache", member_keys_cache)
              IO.puts("public key exists")
              is_block_existed = true
              # if current block exists, put it into blockstamp_cache
              blockstamp_cache = Map.put(blockstamp_cache, blockstamp, :os.system_time())
              ws2p_cache = Map.put(ws2p_cache, "blockstamp_cache", blockstamp_cache)

              if is_block_existed do
                IO.puts("block exists")

                new_head = %{
                  "blockstamp" => blockstamp,
                  "message" => head["message"],
                  "sig" => head["sig"],
                  "messageV2" => head["messageV2"],
                  "sigV2" => head["sigV2"],
                  "step" => step
                }

                # update new_heads_cache
                new_heads_cache = Map.put(new_heads_cache, full_id, new_head)
                # update ws2p
                ws2p_cache = Map.put(ws2p_cache, "new_heads_cache", new_heads_cache)
                head_verification(current_tail, ws2p_cache)
              else
                IO.puts("current head contains an unexisted block")
                Logger.error("current head contains an unexisted block")
                nil
              end
            else
              IO.puts("Current head's issuer is not a duniter member")
              Logger.error("Current head's issuer is not a duniter member")
              nil
            end
          else
            IO.puts("This head doesn't meet HEAD Rebound policy")
            Logger.error("This head doesn't meet HEAD Rebound policy")
            nil
          end
        else
          IO.puts("Head's signature is invalid")
          Logger.error("Head's signature is invalid")
          nil
        end
      else
        IO.puts("Head's format is invalid")
        Logger.error("Head's format is invalid")
        nil
      end
    end
  end

  defp is_member_key(member_keys_cache, pubkey) do
    """
    this.isMemberKey(pub):
            1. check memberkeysCache, memberkeysCache is a cache in this genserver. %{pubkey, date}
            2. if not in memberkeysCache, searched db, each time after we searched db, we stored this pubkey in memberkeysCache
            3. check memberkeysCache again and update its value as the current time
    """

    is_member = false

    if member_keys_cache[pubkey] do
      is_member = true
    end

    # TODO: seach if member is in db, if it's in db, set is_member as true
    # Do we have this block in the DB?
    if not is_member do
      # if member is in db
      is_member = true
    end

    is_member
  end

  defp exists_block(blockstamp_cache, blockstamp) do
    exists = false

    if blockstamp_cache[blockstamp] do
      exists = true
    end

    # TODO: searched the db to see if there is this block
    """
    if (!exists) {
      exists = !!(await this.server.dal.getAbsoluteBlockInForkWindowByBlockstamp(
        blockstamp
      ));
    }
    """

    if not exists do
      # Do we have this block in the DB?
      exists = true
    end

    exists
  end

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

  def handle_call({:gen_new_head_for_new_block, block}, _from, ws2p_cache) do
    # check block information, if it's all valid, if block is good, do following

    pubkey = block["issuer"]
    # seckey = GenServer.call(:keypair, :get_seckey)
    seckey = ""
    ws2pid = ""
    # ws2pid = GenServer.call(:ws2pid, :get_ws2p_id)
    blockstamp = block["number"] <> "-" <> block["hash"]

    message =
      "WS2POCA:HEAD:1:" <>
        pubkey <> ":" <> blockstamp <> ":" <> ws2pid <> ":duniter:1.8.1:1"

    messageV2 =
      "WS2POCA:HEAD:1:" <>
        pubkey <> ":" <> blockstamp <> ":" <> ws2pid <> ":duniter:1.8.1:1:1:1"

    if Regex.compile!(Constants.head_v2_regexp()) |> Regex.match?(messageV2) and
         Regex.compile!(Constants.head_v1_regexp()) |> Regex.match?(message) do
      sigV2 = Crypto.digital_signature(messageV2, seckey)
      sig = Crypto.digital_signature(message, seckey)
      step = 0
      my_full_id = pubkey <> "-" <> ws2pid

      broadcast_message = %{
        message: message,
        sig: sig,
        messageV2: messageV2,
        sigV2: sigV2,
        step: step
      }

      # update headcache
      [heads_cache, member_keys_cache, blockstamp_cache] = ws2p_cache
      heads_cache = Map.put(heads_cache, my_full_id, broadcast_message)
      ws2p_cache = Map.put(ws2p_cache, "heads_cache", heads_cache)
      {:ok, broadcast_message, ws2p_cache}
    end

    {:stop, :error, "Invalid block, can't generate a new head for it"}
  end
end
