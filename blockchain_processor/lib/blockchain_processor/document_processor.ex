defmodule DocumentProcessor do

  def process_identity(%{uid: uid, pub: pub, block_uid: block_uid, block_stamp: block_stamp}) do
    changeset = LocalIIndex.changeset(%LocalIIndex{}, %{op: "CREATE", uid: uid, pub: pub, created_on: block_uid, written_on: block_stamp, member: true, was_member: false, kick: false} )
    Repo.insert(changeset)
  end

end
