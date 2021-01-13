defmodule Block.Processor do
  def process(block) do
    ## create local indexes
    local_iindex = :ets.new(:local_iindex,[:set,:public])
    local_iindex = :ets.new(:local_iindex,[:set,:public])
    ## validate identities
    ## add identities:
    :lists.foreach(fn id -> Index.Generation.add_identity(id) end, block.identities)

  end

end
