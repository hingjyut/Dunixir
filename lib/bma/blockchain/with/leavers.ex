defmodule BMA.Blockchain.With.Leavers do
  def get do
    {:ok, blocks} = :dets.open_file(:block, [{:file, 'data/block'}, {:type, :set}])
    result = []

    result =
      result ++
        :dets.traverse(
          :block,
          fn {_, value} ->
            if(value["leavers"] != []) do
              {:continue, value["number"]}
            else
              :continue
            end
          end
        )

    JSON.encode!(result: [blocks: result])
  end
end
