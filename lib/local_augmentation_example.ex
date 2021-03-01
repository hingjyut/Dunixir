defmodule Index.Augmentation do
  defmodule BIndex do
    ## BR_G01
    def number(global_bindex, local_bindex) do
      key = :ets.first(local_bindex)
      [{key, head}] = :ets.lookup(local_bindex, key)

      case :dets.lookup(global_bindex, :last_block) do
        [] ->
          :ets.insert(local_bindex, {key, Map.merge(head, %{number: 0})})
          :dets.insert(global_bindex, {:last_block, 0})

        _ ->
          [{:last_block, last_block}] = :dets.lookup(global_bindex, :last_block)
          :ets.insert(local_bindex, {key, Map.merge(head, %{number: last_block + 1})})
          :dets.insert(global_bindex, {:last_block, last_block + 1})
      end
    end

    ## BR_G02
    def previousHash(global_bindex, local_bindex) do
      key = :ets.first(local_bindex)
      [{key, head}] = :ets.lookup(local_bindex, key)

      if head.number > 0 do
        [[previousHash]] =
          :dets.match(global_bindex, {:_, %{number: head.number - 1, hash: :"$1"}})

        :ets.insert(local_bindex, {key, Map.merge(head, %{previousHash: previousHash})})
      else
        :ets.insert(local_bindex, {key, Map.merge(head, %{previousHash: nil})})
      end
    end

    ## BR_G03
    def previousIssuer(global_bindex, local_bindex) do
      # get the head key
      key = :ets.first(local_bindex)
      # get the head content
      [{key, head}] = :ets.lookup(local_bindex, key)
      # recent bloc
      if head.number > 0 do
        # get head-1's issuer
        [[previousIssuer]] =
          :dets.match(global_bindex, {:_, %{number: head.number - 1, issuer: :"$1"}})

        # add Previousissuer
        :ets.insert(local_bindex, {key, Map.merge(head, %{previousIssuer: previousIssuer})})
      else
        # PI is nil
        :ets.insert(local_bindex, {key, Map.merge(head, %{previousIssuer: nil})})
      end
    end

    ## BR_G06
    def issuersFrameVar(global_bindex, local_bindex) do
      key = :ets.first(local_bindex)
      [{key, head}] = :ets.lookup(local_bindex, key)

      if head.number == 0 do
        :ets.insert(local_bindex, {key, Map.merge(head, %{issuersFrameVar: 0})})
      else
        [[head_1_id]] = :dets.match(global_bindex, {:"$1", %{number: head.number - 1}})
        [{_key_1, head_1}] = :dets.lookup(global_bindex, head_1_id)
        variation = head_1.issuersFrameVar + 5 * (head.issuersCount - head_1.issuersCount)

        case head_1.issuersFrameVar do
          x when x > 0 -> variation - 1
          x when x < 0 -> variation + 1
          0 -> variation
        end
        |> (&:ets.insert(local_bindex, {key, Map.merge(head, %{issuersFrameVar: &1})})).()
      end
    end


    ## BR_G10
    def membersCount(local_iindex, global_bindex, local_bindex) do
      key = :ets.first(local_bindex)
      [{key, head}] = :ets.lookup(local_bindex, key)

      if head.number == 0 do
        count = length(:ets.match(local_iindex, {:"$1", %{member: true}}))
        :ets.insert(local_bindex, {key, Map.merge(head, %{membersCount: count})})
      else
        [{_key2, last_block}] =
          :dets.match_object(global_bindex, {:_, %{number: head.number - 1}})

        count =
          last_block.membersCount + length(:ets.match(local_iindex, {:"$1", %{member: true}})) -
            length(:ets.match(local_iindex, {:"$1", %{member: false}}))

        :ets.insert(local_bindex, {key, Map.merge(head, %{membersCount: count})})
      end
    end

    ## BR_G11 part 1
    def udTime(global_bindex, local_bindex) do
      # UD production
      [{key, head}] = find_first_local_bindex_entry(local_bindex)
      conf = ConfDTO.mockConfDTO()

      if head.number == 0 do
        :ets.insert(local_bindex, {key, Map.merge(head, %{udTime: conf.udTime0})})
      else
        [[head_1_id]] = :dets.match(global_bindex, {:"$1", %{number: head.number - 1}})
        [{_key_1, head_1}] = :dets.lookup(global_bindex, head_1_id)

        if head_1.udTime <= head.medianTime do
          :ets.insert(local_bindex, {key, Map.merge(head, %{udTime: head_1.udTime + conf.dt})})
        else
          :ets.insert(local_bindex, {key, Map.merge(head, %{udTime: head_1.udTime})})
        end
      end

      udReevalTime(global_bindex, local_bindex)
    end

    ## BR_G11 part 2
    def udReevalTime(global_bindex, local_bindex) do
      [{key, head}] = find_first_local_bindex_entry(local_bindex)
      conf = ConfDTO.mockConfDTO()

      if head.number == 0 do
        :ets.insert(local_bindex, {key, Map.merge(head, %{udReevalTime: conf.udReevalTime0})})
      else
        [[head_1_id]] = :dets.match(global_bindex, {:"$1", %{number: head.number - 1}})
        [{_key_1, head_1}] = :dets.lookup(global_bindex, head_1_id)

        if head_1.udReevalTime <= head.medianTime do
          :ets.insert(
            local_bindex,
            {key, Map.merge(head, %{udReevalTime: head_1.udReevalTime + conf.dtReeval})}
          )
        else
          :ets.insert(local_bindex, {key, Map.merge(head, %{udReevalTime: head_1.udReevalTime})})
        end
      end
    end

    ## BR_G12 part 1
    def unitBaseBR_G12(global_bindex, local_bindex) do
      [{key, head}] = find_first_local_bindex_entry(local_bindex)

      if head.number == 0 do
        :ets.insert(local_bindex, {key, Map.merge(head, %{unitBase: 0})})
      else
        [[unitBase]] =
          :dets.match(global_bindex, {:_, %{number: head.number - 1, unitBase: :"$1"}})

        :ets.insert(local_bindex, {key, Map.merge(head, %{unitBase: unitBase})})
      end
    end

    ## BR_G99
    def currency(global_bindex, local_bindex) do
      [{key, head}] = find_first_local_bindex_entry(local_bindex)

      if head.number > 0 do
        [[currency]] =
          :dets.match(global_bindex, {:_, %{number: head.number - 1, currency: :"$1"}})

        :ets.insert(local_bindex, {key, Map.merge(head, %{currency: currency})})
      else
        :ets.insert(local_bindex, {key, Map.merge(head, %{currency: nil})})
      end
    end

    def find_first_local_bindex_entry(local_bindex) do
      key = :ets.first(local_bindex)
      :ets.lookup(local_bindex, key)
    end
  end

  defmodule IIndex do
    ## BR_G20
    def uidUnique(local_iindex, global_iindex, key) do
      # uid is supposed to be unique for local tables
      [{key, entry}] = :ets.lookup(local_iindex, key)
      # match global index entries on uid
      if :dets.match(global_iindex, {:"$1", %{uid: entry.uid}}) == [] do
        :ets.insert(local_iindex, {key, Map.merge(entry, %{uidUnique: true})})
      else
        :ets.insert(local_iindex, {key, Map.merge(entry, %{uidUnique: false})})
      end
    end

    ## BR_G21
    def pubUnique(local_iindex, global_iindex, key) do
      ## key is supposed to be unique for local tables
      [{key, entry}] = :ets.lookup(local_iindex, key)
      ## match global index entries on public key and op
      if :dets.match(global_iindex, {:"$1", %{pub: entry.pub, op: "CREATE"}}) == [] do
        ## Map.merge(entry,%{pubUnique: ...}) appends the entry and the new field
        :ets.insert(local_iindex, {key, Map.merge(entry, %{pubUnique: true})})
      else
        :ets.insert(local_iindex, {key, Map.merge(entry, %{pubUnique: false})})
      end
    end

    ## BR_G33
    def excludedIsMember(local_iindex, global_iindex, key) do
      ## key is supposed to be unique for local tables
      [{key, entry}] = :ets.lookup(local_iindex, key)

      if entry.member != false do
        :ets.insert(local_iindex, {key, Map.merge(entry, %{excludedIsMember: true})})
      else
        list_pub = :dets.match(global_iindex, {:_, %{pub: entry.pub, member: :"$2"}})

        excludedIsMember =
          is_nil(
            Enum.find_value(list_pub, fn elt ->
              [member] = elt
              !member
            end)
          )

        :ets.insert(local_iindex, {key, Map.merge(entry, %{excludedIsMember: excludedIsMember})})
      end
    end

    ## BR_G35
    def isBeingKicked(local_iindex, key) do
      # Get the entry waiting to be verified
      [{key, entry}] = :ets.lookup(local_iindex, key)
      :ets.insert(local_iindex, {key, Map.merge(entry, %{isBeingKicked: !entry.member})})
    end
  end

  defmodule MIndex do
    ## BR_G34
    def isBeingRevoked(local_mindex, key) do
      # Get the entry waiting to be verified
      [{key, entry}] = :ets.lookup(local_mindex, key)

      :ets.insert(
        local_mindex,
        {key,
         Map.merge(entry, %{
           isBeingRevoked: Map.has_key?(entry, :revoked_on) && !is_nil(entry.revoked_on)
         })}
      )
    end
  end

  defmodule CIndex do
    ## BR_G42
    def toNewcomer(local_cindex, local_iindex, key) do
      # Get the entry waiting to be verified
      [{key, entry}] = :ets.lookup(local_cindex, key)

      :ets.match(local_iindex, {:"$1", %{member: true, pub: entry.receiver}})
      |> Enum.count()
      |> (fn x -> Map.merge(entry, %{toNewcomer: x != 0}) end).()
      |> (&:ets.insert(local_cindex, {key, &1})).()
    end
  end

  defmodule SIndex do
    def checkUnitBase(local_sindex, global_bindex, key) do
      # Get the entry waiting to be verified
      [{_key, entry}] = :ets.lookup(local_sindex, key)
      # Get the block number of HEAD in global_bindex
      [last_block: head_nb] = :dets.lookup(global_bindex, :last_block)
      # The entry's unitbase is valid only if it isn't bigger than block number of HEAD~1
      entry.base <= head_nb - 1
    end
  end
end
