defmodule BlocksFetcher do
  @moduledoc """
  This module is used to sync blocks
  """
  # use GenServer, restart: :transient
  require Logger

  @base_url 'https://g1-test.duniter.org/blockchain/blocks/250/'
  @filepath "data/blocks/"

  def fetch_all_blocks() do
    File.mkdir('data')
    File.mkdir('data/blocks')
    # generate keypairs, peercards, and blocks back
    KeypairFileGenerator.generate_file_if_nonexistent()
    G1TestPeersFetcher.fetch_peers()
    fetch_blocks_starting_at(0)
  end

  def fetch_blocks_starting_at(block_number) do
    current_url = @base_url ++ to_charlist(block_number)
    Logger.info("Getting blocks from #{current_url}")
    # if current url has information, stores them into a json file, else stop the loop
    case :httpc.request(:get, {current_url, []}, [], []) do
      {:ok, resp} ->
        case resp do
          {{_, 200, 'OK'}, _headers, '[]'} ->
            Logger.info("----- [done] Finished synchronization for blocks -----")
            {:stop, :normal, "Sync blocks success"}

          {{_, 200, 'OK'}, _headers, body} ->
            filename = @filepath <> "chunks_" <> to_string(div(block_number, 250))
            File.write!(filename, body)
            Logger.info("Blocks have been stored in #{filename}")
            fetch_blocks_starting_at(block_number + 250)

          _ ->
            Logger.info(
              "I sent too many requests to the server, I'm gonna loop myself till it sends me messages again"
            )

            fetch_blocks_starting_at(block_number)
        end

      {:error, reason} ->
        {:stop, reason}
    end
  end
end
