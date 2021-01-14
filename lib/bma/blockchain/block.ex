defmodule BMA.Blockchain.Block do

    require Logger


    def get(number) do
        {n, _} = :string.to_integer(number)
        {:ok, :block} = :dets.open_file(:block , [{:file, 'data/block'} , {:type, :set}])
        case :dets.lookup(:block, n) do 
            [] -> Poison.encode!(%{"ucode" => 2011, "message" => "Block not found"})
            [{n, block}] -> JSON.encode!(block)
        end
    end
end