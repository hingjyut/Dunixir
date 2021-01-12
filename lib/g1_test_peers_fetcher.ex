defmodule G1TestPeersFetcher do
    require Logger

    @base_url 'https://g1-test.duniter.org/network/peers'
    @filename "data/peers.json"

    def fetch_peers() do
        case :httpc.request(:get, {@base_url, []}, [], []) do
            {:ok, resp}
                 ->
                    {{_, 200, 'OK'}, _headers, body} = resp
                    Logger.info("Writting peercards file")
                    File.write!(@filename, body)
                    {:ok, "Got peers"}
            {:error, reason}
                ->  reason
       end
    end

end
