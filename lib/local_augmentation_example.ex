defmodule Index.Augmentation do

  defmodule IndexUtility do
    #################################################
    #
    # Utility functions
    #
    #################################################
    def range(start_number, end_number, global_bindex) do
      # records are order by number DESC
      bindexes_records = :dets.match(global_bindex, {:_, :"$1"}) |> List.flatten() |> Enum.sort(&(&1.number > &2.number))
      end_number = min(end_number, length(bindexes_records))

      # theRange is a list contains bindex's key, its format likes [%{issuer: "a", issuersFrame: 3, number: 2},%{issuer: "b", issuersFrame: 2, number: 1}]
      if start_number == 1 do
        Enum.slice(bindexes_records, -end_number..0)
        # Enum.reverse(the_range)
      else
        Enum.slice(bindexes_records, -end_number..(-start_number + 1))
        # Enum.reverse(the_range)
      end
    end

    def find_first_local_bindex_entry(local_bindex) do
      key = :ets.first(local_bindex)
      :ets.lookup(local_bindex, key)
    end

    def duniter_reduce(records) do
      Enum.reduce(l,%{},&Map.merge(&1,&2,fn _k,v1,v2 ->
        case {v1,v2} do
          {nil,nil} -> nil
          {nil,value} -> value
          {value, nil} -> value
          {value, _other} -> value
        end
      end
      ))
      end
    end
  end

  defmodule BIndex do
    def conf, do: ConfDTO.mockConfDTO()
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

    ## BR_G04
    def issuersCount(global_bindex, local_bindex) do
      [{key, head}] =IndexUtility.find_first_local_bindex_entry(local_bindex)

      if head.number == 0 do
        :ets.insert(local_bindex, {key, Map.merge(head, %{issuersCount: 0})})
      else
        [[issuers_frame]] =
          :dets.match(global_bindex, {:_, %{number: head.number - 1, issuersFrame: :"$1"}})

        bindex_records_in_range = IndexUtility.range(1, issuers_frame, global_bindex)
        uniq_issuers_in_range = Enum.map(bindex_records_in_range, fn x -> x.issuer end) |> Enum.uniq()

        :ets.insert(
          local_bindex,
          {key, Map.merge(head, %{issuersCount: Enum.count(uniq_issuers_in_range)})}
        )
      end
    end

    ## BR_G05
    def issuersFrame(global_bindex, local_bindex) do
      [{key, head}] =IndexUtility.find_first_local_bindex_entry(local_bindex)

      if head.number == 0 do
        :ets.insert(local_bindex, {key, Map.merge(head, %{issuersFrame: 1})})
      else
        [[head_1_id]] = :dets.match(global_bindex, {:"$1", %{number: head.number - 1}})
        [{_key_1, head_1}] = :dets.lookup(global_bindex, head_1_id)

        cond do
          head_1.issuersFrameVar > 0 ->
            :ets.insert(
              local_bindex,
              {key, Map.merge(head, %{issuersFrame: head_1.issuersFrame + 1})}
            )

          head_1.issuersFrameVar < 0 ->
            :ets.insert(
              local_bindex,
              {key, Map.merge(head, %{issuersFrame: head_1.issuersFrame - 1})}
            )

          true ->
            :ets.insert(
              local_bindex,
              {key, Map.merge(head, %{issuersFrame: head_1.issuersFrame})}
            )
        end
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

    ## BR_G11
    def udTime(global_bindex, local_bindex) do
      # UD production
      [{key, head}] =IndexUtility.find_first_local_bindex_entry(local_bindex)

      if head.number == 0 do
        :ets.insert(local_bindex, {key, Map.merge(head, %{udTime: conf().udTime0})})
      else
        [[head_1_id]] = :dets.match(global_bindex, {:"$1", %{number: head.number - 1}})
        [{_key_1, head_1}] = :dets.lookup(global_bindex, head_1_id)

        if head_1.udTime <= head.medianTime do
          :ets.insert(local_bindex, {key, Map.merge(head, %{udTime: head_1.udTime + conf().dt})})
        else
          :ets.insert(local_bindex, {key, Map.merge(head, %{udTime: head_1.udTime})})
        end
      end

      # update head
      [{key, head}] = :ets.lookup(local_bindex, key)

      if head.number == 0 do
        :ets.insert(local_bindex, {key, Map.merge(head, %{udReevalTime: conf().udReevalTime0})})
      else
        [[head_1_id]] = :dets.match(global_bindex, {:"$1", %{number: head.number - 1}})
        [{_key_1, head_1}] = :dets.lookup(global_bindex, head_1_id)

        if head_1.udReevalTime <= head.medianTime do
          :ets.insert(
            local_bindex,
            {key, Map.merge(head, %{udReevalTime: head_1.udReevalTime + conf().dtReeval})}
          )
        else
          :ets.insert(local_bindex, {key, Map.merge(head, %{udReevalTime: head_1.udReevalTime})})
        end
      end
    end

    ## BR_G12
    def unitBaseBR_G12(global_bindex, local_bindex) do
      [{key, head}] =IndexUtility.find_first_local_bindex_entry(local_bindex)

      if head.number == 0 do
        :ets.insert(local_bindex, {key, Map.merge(head, %{unitBase: 0})})
      else
        [[unitBase]] =
          :dets.match(global_bindex, {:_, %{number: head.number - 1, unitBase: :"$1"}})

        :ets.insert(local_bindex, {key, Map.merge(head, %{unitBase: unitBase})})
      end
    end

    ## BR_G13
    def dividend(global_bindex, local_bindex) do
      [{key, head}] =IndexUtility.find_first_local_bindex_entry(local_bindex)
      # UD re-evaluation
      if head.number == 0 do
        :ets.insert(local_bindex, {key, Map.merge(head, %{dividend: conf().ud0})})
      else
        [[head_1_id]] = :dets.match(global_bindex, {:"$1", %{number: head.number - 1}})
        [{_key_1, head_1}] = :dets.lookup(global_bindex, head_1_id)

        if head.udReevalTime != head_1.udReevalTime do
          previousUB = head_1.unitBase

          dividend =
            Float.ceil(
              head_1.dividend +
                :math.pow(conf().c, 2) * Float.ceil(head_1.massReeval / :math.pow(10, previousUB)) /
                  head.membersCount /
                  (conf().dtReeval / conf().dt)
            )

          :ets.insert(local_bindex, {key, Map.merge(head, %{dividend: dividend})})
        else
          :ets.insert(local_bindex, {key, Map.merge(head, %{dividend: head_1.dividend})})
        end
      end

      [{key, head}] = :ets.lookup(local_bindex, key)

      # UD creation
      if head.number == 0 do
        :ets.insert(local_bindex, {key, Map.merge(head, %{new_dividend: nil})})
      else
        [[head_1_id]] = :dets.match(global_bindex, {:"$1", %{number: head.number - 1}})
        [{_key_1, head_1}] = :dets.lookup(global_bindex, head_1_id)

        if head.udTime != head_1.udTime do
          :ets.insert(local_bindex, {key, Map.merge(head, %{new_dividend: head.dividend})})
        else
          :ets.insert(local_bindex, {key, Map.merge(head, %{new_dividend: nil})})
        end
      end
    end

    ## BR_G14

    def unitBase(local_bindex) do
      [{key, head}] =IndexUtility.find_first_local_bindex_entry(local_bindex)

      if head.dividend >= :math.pow(10, Constants.nbDigitsUD()) do
        :ets.insert(
          local_bindex,
          {key, Map.merge(head, %{dividend: Float.ceil(head.dividend / 10)})}
        )

        [{key, head}] = :ets.lookup(local_bindex, key)
        :ets.insert(local_bindex, {key, Map.merge(head, %{new_dividend: head.dividend})})
        :ets.insert(local_bindex, {key, Map.merge(head, %{unitBase: head.unitBase + 1})})
      end
    end

    ## BR_G99
    def currency(global_bindex, local_bindex) do
      [{key, head}] =IndexUtility.find_first_local_bindex_entry(local_bindex)

      if head.number > 0 do
        [[currency]] =
          :dets.match(global_bindex, {:_, %{number: head.number - 1, currency: :"$1"}})

        :ets.insert(local_bindex, {key, Map.merge(head, %{currency: currency})})
      else
        :ets.insert(local_bindex, {key, Map.merge(head, %{currency: nil})})
      end
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

        :ets.insert(
          local_iindex,
          {key, Map.merge(entry, %{excludedIsMember: excludedIsMember})}
        )
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

    def fromMember(local_cindex,global_iindex, key) do
        # Get the entry waiting to be verified
        [{key, entry}] = :ets.lookup(local_cindex, key)
        fromMember_data = :ets.match(global_iindex, {:"$1", %{pub: entry.issuer}})
        |>Enum.map(&:ets.lookup(global_iindex,&1))
        |>IndexUtility.duniter_reduce()
        |>Map.get(:member)
      :ets.insert(local_cindex, {key, Map.merge(entry, %{fromMember: fromMember_data})})
    end

    def toMember(local_cindex,global_iindex, key) do
      # Get the entry waiting to be verified
      [{key, entry}] = :ets.lookup(local_cindex, key)
      toMember_data = :ets.match(global_iindex, {:"$1", %{pub: entry.issuer}})
      |>Enum.map(&:ets.lookup(global_iindex,&1))
      |>IndexUtility.duniter_reduce()
      |>Map.get(:member)
    :ets.insert(local_cindex, {key, Map.merge(entry, %{toMember: toMember_data})})
  end

  def toLeaver(local_cindex,local_mindex, key) do
    # Get the entry waiting to be verified
    [{key, entry}] = :ets.lookup(local_cindex, key)
    toLeaver_data = :ets.match(local_mindex, {:"$1", %{pub: entry.receiver}})
    |>Enum.map(&:ets.lookup(local_mindex,&1))
    |>IndexUtility.duniter_reduce()
    |>Map.get(:leaving)
  :ets.insert(local_cindex, {key, Map.merge(entry, %{toLeaver: toLeaver_data})})
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
