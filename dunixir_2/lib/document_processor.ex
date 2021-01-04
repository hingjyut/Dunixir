defmodule Document.Processor do

  def add_identity(blockstamp, local_iindex,local_mindex,%{"pub" => pub,
  "sig" => sig,
  "block_uid" => block_uid,
  "user_id"=> user_id}) do
    #TODO match signature (crypto)

    {:ok,local_iindex} = Local.I.Index.insert(local_iindex,%{"op" => "CREATE",
    "uid" => user_id,
    "pub" => pub,
    "created_on" => block_uid,
    "written_on" => blockstamp,
    "member" => true,
    "wasMember" => true,
    "kick" => false})
    {:ok, local_mindex} = Local.M.Index.insert(local_mindex,%{"op" => "CREATE",
    "pub" => pub,
    "created_on" => block_uid,
    "written_on" => blockstamp,
    "expired_on" => 0,
    "expires_on" => Constants.medianTime + Constants.msValidity,
    "revokes_on" => Constants.medianTime + Constants.msValidity*2,
    "chainable_on" => Constants.medianTime + Constants.msPeriod,
    "type" => "JOIN",
    "revoked_on" => nil,
    "leaving" => false})

    {:ok,local_iindex,local_mindex}

  end

  def add_joiner(blockstamp,local_iindex, local_mindex, %{"pub"=> pub,
  "sig" => sig,
  "m_block_uid" => m_block_uid,
  "i_block_uid" => _i_block_uid,
  "user_id" => _user_id}) do
    #TODO match signature
    match_create = Enum.find_value(local_mindex, fn x -> x["op"]=="CREATE" && x["pub"]==pub end )
    case match_create do
      nil ->
        {:ok,local_iindex} = Local.I.Index.insert(local_iindex, %{"op" => "UPDATE",
        "uid" => nil,
        "pub" => pub,
        "created_on" => nil,
        "written_on" => blockstamp,
        "member" => true,
        "wasMember" => nil,
        "kick" => nil})
        {:ok,local_mindex} = Local.M.Index.insert(local_mindex,%{"op" => "UPDATE",
        "pub" => pub,
        "created_on" => m_block_uid, #ambiguité de la spec (m ou i ?)
        "written_on" => blockstamp,
        "expired_on" => 0,
        "expires_on" => Constants.medianTime + Constants.msValidity,
        "revokes_on" => Constants.medianTime + Constants.msValidity*2,
        "chainable_on" => Constants.medianTime + Constants.msPeriod,
        "type" => "JOIN",
        "revocation" => nil,
        "revoked_on" => nil,
        "leaving" => nil})

        {:ok,local_iindex,local_mindex}
      _ ->
        {:ok,local_iindex,local_mindex}

    end
  end

  def add_active(blockstamp,local_mindex,%{"pub"=> pub,
  "sig" => sig,
  "m_block_uid" => m_block_uid,
  "i_block_uid" => _i_block_uid,
  "user_id" => _user_id}) do
    {:ok,local_mindex} = Local.M.Index.insert(local_mindex,%{"op" => "UPDATE",
    "pub" => pub,
    "created_on" => m_block_uid, #ambiguité de la spec (m ou i ?)
    "written_on" => blockstamp,
    "expired_on" => 0,
    "expires_on" => Constants.medianTime + Constants.msValidity,
    "revokes_on" => Constants.medianTime + Constants.msValidity*2,
    "chainable_on" => Constants.medianTime + Constants.msPeriod,
    "type" => "RENEW",
    "revoked_on" => nil,
    "revocation" => nil,
    "leaving" => nil})

    {:ok,local_mindex}
  end

  def add_leaver(blockstamp,local_mindex,%{"pub"=> pub,
  "sig" => sig,
  "m_block_uid" => m_block_uid,
  "i_block_uid" => _i_block_uid,
  "user_id" => _user_id}) do
    {:ok,local_mindex} = Local.M.Index.insert(local_mindex,%{"op" => "UPDATE",
    "pub" => pub,
    "created_on" => m_block_uid, #ambiguité de la spec (m ou i ?)
    "written_on" => blockstamp,
    "expired_on" => 0,
    "expires_on" => nil,
    "revokes_on" => nil,
    "chainable_on" => nil,
    "type" => "LEAVE",
    "revoked_on" => Constants.medianTime,
    "revocation" => nil,
    "leaving" => true})

    {:ok,local_mindex}
  end

  def add_revoked(blockstamp,local_mindex,%{"pub"=>pub,
  "sig"=>sig}) do
    {:ok,local_mindex} = Local.M.Index.insert(local_mindex,%{"op" => "UPDATE",
    "pub" => pub,
    "created_on" => nil, #ambiguité de la spec (BLOCK_UID???)
    "written_on" => blockstamp,
    "expired_on" => 0,
    "expires_on" => nil,
    "revokes_on" => nil,
    "chainable_on" => nil,
    "type" => "REV",
    "revoked_on" => Constants.medianTime,
    "revocation" => sig,
    "leaving" => false}
    )

    {:ok,local_mindex}

  end

  def add_excluded(blockstamp,local_iindex,%{"pub"=>pub }) do
    {:ok,local_iindex} = Local.I.Index.insert(local_iindex, %{"op" => "UPDATE",
    "uid" => nil,
    "pub" => pub,
    "created_on" => nil,
    "written_on" => blockstamp,
    "member" => false,
    "wasMember" => nil,
    "kick" => false})
    {:ok,local_iindex}
  end

  def add_certification(blockstamp, local_cindex,%{"from"=>from,
  "to" => to,
  "block_id" => block_id,
  "sig" => sig}) do
    {:ok, local_cindex} = Local.C.Index.insert(local_cindex,%{"op" => "CREATE",
    "issuer" => from,
    "receiver" => to,
    "created_on" => block_id,
    "written_on" => blockstamp,
    "sig" => sig,
    "expires_on" => Constants.medianTime + Constants.sigValidity,
    "expired_on" => 0,
    "chainable_on" => Constants.medianTime + Constants.sigPeriod,
    "replayable_on" => Constants.medianTime + Constants.sigReplay})
    {:ok,local_cindex}

  end

end
