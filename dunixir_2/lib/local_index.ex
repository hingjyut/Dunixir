defmodule Local do

  defmodule I.Index do

    def insert(local_iindex,new_entry=%{"op" => op,
    "uid" => uid,
    "pub" => pub,
    "created_on" => _created_on,
    "written_on" => written_on,
    "member" => _member,
    "wasMember" => _wasMember,
    "kick" => _kick}) do

      # Unicity conditions
      uid_dup = Enum.find_value(local_iindex, fn x -> x["uid"]==uid end )
      pubkey_dup = Enum.find_value(local_iindex, fn x -> x["pub"]==pub end )

      # Not nil conditions
      op_not_valid = !(op == "CREATE" || op == "UPDATE")
      pubkey_nil = is_nil(pub)
      written_on_nil = is_nil(written_on)

      cond do
        uid_dup -> {:error, "uid already in local iindex"}
        pubkey_dup -> {:error, "pub already in local iindex"}
        op_not_valid -> {:error, "op must be CREATE or UPDATE"}
        pubkey_nil -> {:error, "pub cannot be nil"}
        written_on_nil -> {:error, "written_on cannot be nil"}
        true ->
          {:ok, local_iindex ++ new_entry}
      end
    end
  end

  defmodule M.Index do
    def insert(local_mindex,new_entry=%{"op" => op,
    "pub" => pub,
    "created_on" => _created_on,
    "written_on" => written_on,
    "expires_on" => _expires_on,
    "expired_on" => _expired_on,
    "revokes_on" => _revokes_on,
    "revoked_on" => _revoked_on,
    "leaving" => _leaving,
    "revocation" => _revocation,
    "chainable_on" => _chainable_on,
    "type" => _type}) do

      # Unicity conditions
      pubkey_dup = Enum.find_value(local_mindex, fn x -> x["pub"]==pub end )

      # Not nil conditions
      op_not_valid = !(op == "CREATE" || op == "UPDATE")
      pubkey_nil = is_nil(pub)
      written_on_nil = is_nil(written_on)

      cond do
        pubkey_dup -> {:error, "pub already in local mindex"}
        op_not_valid -> {:error, "op must be CREATE or UPDATE"}
        pubkey_nil -> {:error, "pub cannot be nil"}
        written_on_nil -> {:error, "written_on cannot be nil"}
        true ->
          {:ok, local_mindex ++ new_entry}
      end
    end
  end

  defmodule C.Index do
    def insert(local_cindex,new_entry=%{"op" => op,
    "issuer" => issuer,
    "receiver" => receiver,
    "created_on" => created_on,
    "written_on" => written_on,
    "sig" => sig,
    "expires_on" => expires_on,
    "expired_on" => expired_on,
    "chainable_on" => chainable_on,
    "replayable_on" => replayable_on}) do

      # Unicity conditions
      from_to_dup = Enum.find_value(local_cindex, fn x -> x["issuer"]==issuer && x["receiver"]==receiver end )
      from_dup = created_on != 0 && Enum.find_value(local_cindex, fn x -> x["issuer"]==issuer end )

      # Not nil conditions
      op_not_valid = !(op == "CREATE")
      from_nil = is_nil(issuer)
      to_nil = is_nil(receiver)
      created_on_nil = is_nil(created_on)
      written_on_nil = is_nil(written_on)
      sig_nil = is_nil(sig)
      expires_on_nil = is_nil(expires_on)
      expired_on_nil = is_nil(expired_on)
      chainable_on_nil = is_nil(chainable_on)
      replayable_on_nil = is_nil(replayable_on)



      cond do
        op_not_valid -> {:error, "op must be CREATE"}
        from_to_dup -> {:error, "from/to already in local cindex"}
        from_dup -> {:error, "from already in local cindex and created_on != #0"}
        from_nil -> {:error, "issuer cannot be nil"}
        to_nil -> {:error, "receiver cannot be nil"}
        created_on_nil -> {:error, "created_on cannot be nil"}
        written_on_nil -> {:error, "written_on cannot be nil"}
        sig_nil -> {:error, "sig cannot be nil"}
        expires_on_nil -> {:error, "expires_on cannot be nil"}
        expired_on_nil -> {:error, "expired_on cannot be nil"}
        chainable_on_nil -> {:error, "chainable_on cannot be nil"}
        replayable_on_nil -> {:error, "replayable_on cannot be nil"}
        true ->
          {:ok, local_cindex ++ new_entry}
      end
    end
  end

  defmodule S.Index do
    def insert(local_sindex,new_entry=%{"op" => op,
    "tx" => tx,
    "identifier" => identifier,
    "pos" => pos,
    "written_on" => written_on,
    "written_time" => _written_time,
    "amount" => amount,
    "base" => base,
    "locktime" => _locktime,
    "conditions" => conditions,
    "consumed" => consumed}) do

      # Unicity conditions
      up_id_pos_dup = Enum.find_value(local_sindex, fn x -> x["op"]=="UPDATE" && x["identifier"]==identifier && x["pos"]==pos end )
      cre_id_pos_dup = Enum.find_value(local_sindex, fn x -> x["op"]=="CREATE" && x["identifier"]==identifier && x["pos"]==pos end )

      # Not nil conditions
      op_not_valid = !(op == "CREATE" || op == "UPDATE")
      tx_nil = op=="UPDATE" && is_nil(tx)
      id_nil = is_nil(identifier)
      pos_nil = is_nil(pos)
      amount_nil = is_nil(amount)
      base_nil = is_nil(base)
      consumed_nil = is_nil(consumed)
      conditions_nil = is_nil(conditions)
      written_on_nil = is_nil(written_on)


      cond do
        op_not_valid -> {:error, "op must be CREATE or UPDATE"}
        up_id_pos_dup -> {:error, "UPDATE/id/pos already in local sindex"}
        cre_id_pos_dup -> {:error, "CREATE/id/pos already in local sindex"}
        tx_nil -> {:error, "tx cannot be nil"}
        id_nil -> {:error, "identifier cannot be nil"}
        pos_nil -> {:error, "pos cannot be nil"}
        amount_nil -> {:error, "amount cannot be nil"}
        base_nil -> {:error, "base cannot be nil"}
        consumed_nil -> {:error, "consumed cannot be nil"}
        conditions_nil -> {:error, "conditions cannot be nil"}
        written_on_nil -> {:error, "written_on cannot be nil"}
        true ->
          {:ok, local_sindex ++ new_entry}
      end
    end
  end
end


# my_iindex = []
# IO.puts(inspect Local.I.Index.insert(my_iindex,%{"uid" => "toto", "pubkey"=> "123", "block_uid"=> "456", "block_stamp" => "789"}))
# IO.puts(inspect Local.I.Index.insert(my_iindex,%{"uid" => "toto", "pubkey"=> "123", "block_uid"=> "456", "block_stamp" => "789"}))
# IO.puts(inspect Local.I.Index.insert(my_iindex,%{"uid" => "tata", "pubkey"=> "112233", "block_uid"=> "456", "block_stamp" => "789"}))
