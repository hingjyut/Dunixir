defmodule WS2P.Cluster do
  use GenServer
  require Logger

  def start_likn(_args) do
    GenServer.start_link(__MODULE__, [], [])
  end

  def init(_args) do
    # initial heads_cache is an empty map
    {:ok, %{}}
  end

  def handle_call(:get_heads_cache, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:gen_new_head_for_new_block, block}, _from, heads_cache) do
    # check block information, if it's all valid, if block is good, do following

    pubkey = block["issuer"]
    {:ok, seckey} = GenServer.call(:keypair, :get_seckey)
    {:ok, ws2pid} = GenServer.call(:ws2pid, :get_ws2p_id)
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
      Map.put(heads_cache, my_full_id, broadcast_message)
      GenServer.cast(WS2P.Connection, {:send_packet, broadcast_message})
      {:ok, broadcast_message}
    end
    {:stop, :error, "Invalid block, can't generate a new head for it"}
  end

  def heads_recived(heads) do
    # if received_messages["body"]["name"] == "HEAD", do: WS2P.Cluster.heads_recived(received_messages["body"]["heads"])
    # for each head, call head_verification
    new_valid_heads = Enum.map(heads, fn x -> formed_heads(x) end)

    if Enum.all?(new_valid_heads) do
      broadcast_message = Enum.into(new_valid_heads, %{})
      # Broadcast this message
      GenServer.cast(WS2P.Connection, {:send_packet, broadcast_message})
    else
      Logger.error("Stop broadcast these heads")
    end

    # {:reply, to_be_broadcast_heads, to_be_broadcast_heads}
  end

  # This function returns %{pubkey <> "-" <> ws2pid, WS2PHeadCache.t()}
  defp formed_heads(head) do
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

        # Map.put(head, :blockstamp, blockstamp)
        head_verification(head, pubkey, pubkey <> "-" <> ws2pid, blockstamp)

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
        head_verification(head, pubkey, pubkey <> "-" <> ws2pid, blockstamp)

      Regex.compile!(Constants.head_v0_regexp()) |> Regex.match?(head["message"]) ->
        [
          _api,
          _head,
          pubkey,
          blockstamp
        ] = String.split(head["message"], ":")

        # Map.put(head, :blockstamp, blockstamp)
        head_verification(head, pubkey, pubkey <> "-" <> "000000", blockstamp)
    end
  end

  def head_verification(head, pubkey, full_id, blockstamp) do
    # if current head is not in headscache, check it and add it into cache
    # Prevent fields injection
    new_head = %{}

    if (Regex.compile!(Constants.head_v0_regexp()) |> Regex.match?(head["message"]) or
          Regex.compile!(Constants.head_v1_regexp()) |> Regex.match?(head["message"])) and
         Regex.compile!(Constants.signature_regexp()) |> Regex.match?(head["sig"]) and
         (not head.messageV2 or
            Regex.compile!(Constants.head_v2_regexp()) |> Regex.match?(head["messageV2"])) and
         (not head.sigV2 or
            Regex.compile!(Constants.signature_regexp()) |> Regex.match?(head["sigV2"])) and
         Regex.compile!("[0-9]*") |> Regex.match?(head["step"]) do
      sig_ok = Crypto.verify_digital_signature(head.sig, head.message, pubkey)
      sigV2_ok = Crypto.verify_digital_signature(head.sigV2, head.messageV2, pubkey)

      if (sig_ok and sigV2_ok) or sig_ok do
        {:ok, heads_cache} = GenServer.call(__MODULE__, :get_heads_cache)
        step = if heads_cache[full_id]["step"] != nil, do: heads_cache[full_id]["step"], else: 0

        if heads_cache[full_id] == nil or
             Integer.parse(heads_cache[full_id][blockstamp]) < Integer.parse(blockstamp) or
             (head["step"] != nil and head["step"] < step and
                heads_cache[full_id][blockstamp] == blockstamp) do
          is_pubkey_existed = true

          # TODO: figure out how to check is_pubkey_existed and is_block_existed
          # Check that issuer is a member and that the block exists
          if is_pubkey_existed do
            is_block_existed = true

            if is_block_existed do
              Map.put(new_head[full_id], "blockstamp", blockstamp)
              Map.put(new_head[full_id], "message", head["message"])
              Map.put(new_head[full_id], "sig", head["sig"])
              Map.put(new_head[full_id], "messageV2", head["messageV2"])
              Map.put(new_head[full_id], "sigV2", head["sigV2"])
              Map.put(new_head[full_id], "step", step)
              new_head[full_id]
              # need to publish a new head
            else
              Logger.error("current head contains an unexisted block")
              nil
            end
          else
            Logger.error("Current head's issuer is not a duniter member")
            nil
          end
        else
          Logger.error("This head doesn't meet HEAD Rebound policy")
          nil
        end
      else
        Logger.error("Head's signature is invalid")
        nil
      end

      Logger.error("Head's format is invalid")
      nil
    end
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

"""
%{
  "body" => %{
    "heads" => [
      %{
        "message" => "WS2POCAIC:HEAD:1:HAy1hLpHfqrG3xsZRoBVkNigGQZnDfJK2az5MeRYtyNb:694027-0000988886FA69E41386B0E992B66DB4FE77BA4A5B29B5BBD04F85DFEDC80CF3:c4df202c:duniter:1.8.1:1",
        "messageV2" => "WS2POCAIC:HEAD:2:HAy1hLpHfqrG3xsZRoBVkNigGQZnDfJK2az5MeRYtyNb:694027-0000988886FA69E41386B0E992B66DB4FE77BA4A5B29B5BBD04F85DFEDC80CF3:c4df202c:duniter:1.8.1:1:9:9",
        "sig" => "FyUd1YZPFK483p9xJDveDeSPDQUYlr90FEgXDuxGajfc7t7pw7L2zEV/In0zTNX4O+hT8Otan2HTKw//JbkzCQ==",
        "sigV2" => "GZgbXaVUKrFAg4iTYqh9EqmUg0yr/aZeeLEmuT2i9IFK9OBc+3LwdqbYdIdg9dcl3XwdbAFzkkV6qNqip2iCDg==",
        "step" => 2
      }
    ],
    "name" => "HEAD"
  }
}
"""
