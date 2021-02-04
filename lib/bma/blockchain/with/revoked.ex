defmodule BMA.Blockchain.With.Revoked do
    def get do
        {:ok, :block} = :dets.open_file(:block, [{:file, 'data/block'}, {:type, :set}])
        result = []
        result = result ++ :dets.traverse(
            :block,
            fn {_, value} ->
              if(value["revoked"]) != []) do
                  {:continue, value["number"]}
              else
                  :continue
              end
            end
                 )
        JSON.encode!([result: [blocks: result]])
    end

end
