defmodule BMA.Blockchain.Blocks do
  def get(count_string, from_string) do
    {count, _} = :string.to_integer(count_string)
    {from, _} = :string.to_integer(from_string)
    {:ok, :block} = :dets.open_file(:block, [{:file, 'data/block'}, {:type, :set}])

    result =
      Enum.map(from..(from + count - 1), fn n ->
        case :dets.lookup(:block, n) do
          [] -> nil
          [{n, block}] -> block
        end
      end)

    case hd(result) do
      nil -> {:ko, JSON.encode!([])}
      _ -> {:ok, JSON.encode!(blocks: result)}
    end
  end
end
