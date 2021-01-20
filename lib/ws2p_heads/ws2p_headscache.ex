defmodule WS2P.HeadsCache do
  use GenServer
  require Logger

  # Registry.start_link(keys: :unique, name: WS2P.HeadCache.Registry)
  def init(_args) do
    {:ok, %{}}
  end

  @spec start_link(any) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(_args) do
    GenServer.start_link(__MODULE__, [],
      name: {:via, Registry, {WS2P.HeadCache.Registry, :headcache}}
    )
  end

  def handle_call(:get_headcache, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:update_headcache, new_heads_cache}, _old_heads_cache) do
    {:noreply, new_heads_cache}
  end
end
