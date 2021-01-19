# defmodule Server.Conf do

#   def pubkey() do
#     #TODO: read keypair from .yml file
#     "BhQf2fkGAe1EszyZRJqasMr23YLSf1P3mhuYzEoKpgVA"
#   end

#   def seckey() do
#     "2DLT4zDuuQSsEehijzkwCwdvH4vrsp6joBf4rum9Zb8jDTBKhDfZawSYsGeWy56cPDUGbWf5ybJgADNnVcnJ3sek"
#   end

#   def ws2p() do
#     ""
#   end
# end

defmodule Server.Conf.Keypair do

  use GenServer
  def init(_init) do
    #TODO: read keypair from .yml file
    seckey = "2DLT4zDuuQSsEehijzkwCwdvH4vrsp6joBf4rum9Zb8jDTBKhDfZawSYsGeWy56cPDUGbWf5ybJgADNnVcnJ3sek"
    pubkey = "BhQf2fkGAe1EszyZRJqasMr23YLSf1P3mhuYzEoKpgVA"
    {:ok, {pubkey, seckey}}
  end

  def start_link() do
    GenServer.start_link(__MODULE__, [],name: {:via, Registry, {WS2P.HeadCache.Registry, :keypair}})
  end

  def handle_call({:get_pubkey}, _from, state) do
    {pubkey, _} = state
    {:reply, pubkey, state}
  end

  def handle_call({:get_seckey}, _from, state) do
    {pubkey, _} = state
    {:reply, pubkey, state}
  end

end
