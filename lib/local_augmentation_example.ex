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
    def excludedIsMember(local_iindex,global_iindex,key) do
      [{key,entry}] = :ets.lookup(local_iindex,key) ## key is supposed to be unique for local tables
      if entry.member != false do
        :ets.insert(local_iindex,{key,Map.merge(entry,%{excludedIsMember: true})})
      else
        list_pub = :dets.match(global_iindex,{:_,%{pub: entry.pub, member: :"$2"}})
        excludedIsMember = is_nil(Enum.find_value(list_pub, fn elt ->
          [member] = elt
          !member
        end))
        :ets.insert(local_iindex,{key,Map.merge(entry,%{excludedIsMember: excludedIsMember})})
      end
    end
  end
end
