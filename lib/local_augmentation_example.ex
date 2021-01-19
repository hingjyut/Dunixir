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

  defmodule BIndex do
    def membersCount(local_iindex, global_bindex, local_bindex) do
      key = :ets.first(local_bindex)
      [{key, head}] = :ets.lookup(local_bindex,key)

      if head.number == 0 do
        count = length(:ets.match(local_iindex,{:"$1",%{member: true}}))
        :ets.insert(local_bindex,{key,Map.merge(head, %{membersCount: count})})
      else
        [{_key2, last_block}] = :dets.match_object(global_bindex,{:_, %{number: head.number - 1}})
        count = last_block.membersCount + length(:ets.match(local_iindex,{:"$1",%{member: true}})) - length(:ets.match(local_iindex,{:"$1",%{member: false}}))
        :ets.insert(local_bindex,{key,Map.merge(head, %{membersCount: count})})
      end
    end
  end
end
