defmodule BMA.Blockchain.With.Joiners do
  require Logger

  def get do
    {:ok, :block} = :dets.open_file(:block, [{:file, 'data/block'}, {:type, :set}])
    result = []

    result =
      result ++
        :dets.traverse(
          :block,
          fn {_, value} ->
            if(length(value["joiners"]) > 0) do
              {:continue, value["number"]}
            else
              :continue
            end
          end
        )

    JSON.encode!(result: [blocks: result])
  end
end
