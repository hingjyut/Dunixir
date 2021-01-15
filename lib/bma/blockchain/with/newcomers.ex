defmodule BMA.Blockchain.With.Newcomers do
    def get do
        {:ok, blocks} = :dets.open_file(:block , [{:file, 'data/block'} , {:type, :set}])
        first_block_id = :dets.first(blocks)
        list = get_list([], first_block_id, blocks)
        Poison.encode!(
            %{result:
            %{blocks: list
            }})
        end

    @doc """
    Get a list of block id of blocks with non-empty identities
    """
    def get_list(list, id, blocks) do
        case id do
            :"$end_of_table" -> list
            _ ->
                [{_, block}] = :dets.lookup(blocks, id)
                id = :dets.next(blocks, id)
                case block["identities"] do
                    [] ->
                        get_list(list, id, blocks)
                    _ ->
                        list = list ++ block["number"]
                        get_list(list, id, blocks)
                end
        end

    end
end
