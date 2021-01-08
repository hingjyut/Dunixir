defmodule DocumentProcessor do

  def process_identity(%{uid: uid, pub: pub, block_uid: i_block_uid, block_stamp: block_stamp}) do
    changeset_i = LocalIIndex.changeset(%LocalIIndex{}, %{op: "CREATE", uid: uid, pub: pub, created_on: i_block_uid, written_on: block_stamp, member: true, was_member: false, kick: false} )
    changeset_m = LocalMIndex.changeset(%LocalMIndex{},%{op: "CREATE", pub: pub, created_on: i_block_uid, written_on: block_stamp, expired_on: 0, expires_on: 666, revokes_on: 666, chainable_on: 666, type: "JOIN", leaving: false}) 
    Repo.insert(changeset_i)
    Repo.insert(changeset_m)
  end

  def compute_block_hash() do
    #TODO
  end
  

end
