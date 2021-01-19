defmodule WS2P.HeadsCache do
  use GenServer
  require Logger

  @url 'https://g1-test.duniter.org/network/ws2p/heads'

  # Registry.start_link(keys: :unique, name: WS2P.HeadCache.Registry)
  def init(_args) do
    case :httpc.request(:get, {@url, []}, [], []) do
      {:ok, resp} ->
        {{_, 200, 'OK'}, _headers, body} = resp
        Logger.info("Initialized headscache")
        %{"heads" => head_list} = Jason.decode!(body)
        {:ok, {:continue, {:formulate_heads, head_list}}}

      {:error, reason} ->
        Logger.error(reason)
        {:stop, :error, reason}
    end
  end

  @spec start_link(any) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(_args) do
    GenServer.start_link(__MODULE__, [],
      name: {:via, Registry, {WS2P.HeadCache.Registry, :headcache}}
    )
  end

  def handle_continue({:formulate_heads, heads}) do
    initial_headcache = Enum.map(heads, fn x -> get_full_id(x) end) |> Enum.into(%{})
    {:noreply, initial_headcache}
  end

  defp get_full_id(head) do
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
        Map.put(head, :blockstamp, blockstamp)
        {pubkey <> "-" <> ws2pid, head}

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
        Map.put(head, :blockstamp, blockstamp)
        {pubkey <> "-" <> ws2pid, head}

      Regex.compile!(Constants.head_v0_regexp()) |> Regex.match?(head["message"]) ->
        [
          _api,
          _head,
          pubkey,
          blockstamp
        ] = String.split(head["message"], ":")
        Map.put(head, :blockstamp, blockstamp)
        {pubkey <> "-" <> "00000000" , head}
    end
  end

  def handle_call(:get_headcache, _from, state) do
    {:reply, state, state}
  end

  def handle_cast(:update_headcache, new_state) do
    {:noreply, new_state}
  end
end
