defmodule BMA.Blockchain.With.Actives do
  def get do
    {:ok, :block} = :dets.open_file(:block, [{:file, 'data/block'}, {:type, :set}])
    result = []

    result =
      result ++
        :dets.traverse(
          :block,
          fn {_, value} ->
            if(length(value["actives"]) > 0) do
              {:continue, value["number"]}
            else
              :continue
            end
          end
        )

    JSON.encode!(result: [blocks: result])
  end
end
