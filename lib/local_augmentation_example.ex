defmodule Index.Augmentation do
  defmodule IIndex do
    def pubUnique(local_iindex,global_iindex,key) do
      [{key,entry}] = :ets.lookup(local_iindex,key) ## key is supposed to be unique for local tables
      if :dets.match(global_iindex,{:"$1",%{pub: entry.pub}}) == [] do ##match global index entries on public key
       :ets.insert(local_iindex,{key,Map.merge(entry,%{pubUnique: true})}) ## Map.merge(entry,%{pubUnique: ...}) appends the entry and the new field
      else
        :ets.insert(local_iindex,{key,Map.merge(entry,%{pubUnique: false})})
      end
    end

    def uidUnique(local_iindex,global_iindex,key) do
      # uid is supposed to be unique for local tables
      [{key,entry}] = :ets.lookup(local_iindex,key)
      # match global index entries on uid
      if :dets.match(global_iindex,{:"$1",%{uid: entry.uid}}) == [] do
       :ets.insert(local_iindex,{key,Map.merge(entry,%{uidUnique: true})})
      else
        :ets.insert(local_iindex,{key,Map.merge(entry,%{uidUnique: false})})
      end
    end
  end

  defmodule SIndex do

    def checkUnitBase(local_sindex, :global_bindex, key) do
      # Get the entry waiting to be verified
      [{_key,entry}] = :ets.lookup(local_sindex,key)
      # Get the block number of HEAD in global_bindex
      ["last_block": head_nb] = :dets.lookup(:global_bindex, :last_block)
      # The entry's unitbase is valid only if it isn't bigger than block number of HEAD~1
      entry.base <= head_nb - 1
    end
  end

end
