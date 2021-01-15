defmodule BMA.Blockchain.With.Newcomers do

    @doc"""
    Get a list of block ID of blocks with non-empty identitis
    """
    def get do
        {:ok, blocks} = :dets.open_file(:block , [{:file, 'data/block'} , {:type, :set}])
        first_block_id = :dets.first(blocks)
        list = :dets.traverse(
            blocks,
            fn{_, block} ->
                if (block["identities"] != []) do
                    {:continue, block["number"]}
                else
                    :continue
                end
            end
        )

        Poison.encode!(
            %{result:
            %{blocks: list
            }})
        end

end
