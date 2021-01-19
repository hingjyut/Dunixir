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
      ## uid is supposed to be unique for local tables
      [{key,entry}] = :ets.lookup(local_iindex,key) 
      ##match global index entries on uid
      if :dets.match(global_iindex,{:"$1",%{uid: entry.uid}}) == [] do 
       :ets.insert(local_iindex,{key,Map.merge(entry,%{uidUnique: true})}) 
      else
        :ets.insert(local_iindex,{key,Map.merge(entry,%{uidUnique: false})})
      end
    end
  end

end
