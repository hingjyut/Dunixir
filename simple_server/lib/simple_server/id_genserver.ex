defmodule IDGenserver do
  use GenServer
  require Logger
  import Ecto.Query
  @certifs_required 5

  def start(id_pubkey) do
    case GenServer.start_link(__MODULE__, id_pubkey, name: :"#{id_pubkey}_genserver") do
      {:ok, p} ->
        {:ok, p}
      {:error, {:already_started, p}} ->
        {:ok, p}
      err -> err
    end
  end

  def init(id_pubkey) do
    IO.puts("#{id_pubkey}_genserver")
    {:ok, %{id_pubkey: id_pubkey, certifs: []}}
  end


  def handle_call({:certify, %{"from_pubkey" => from_pubkey}, }, _from ,%{id_pubkey: id_pubkey, certifs: certifs})  do

    # We count the certifications and change the membership state in the db and terminate if there is enough.

    count = [from_pubkey|certifs] |> Enum.count
    if count> @certifs_required do
      set_member(id_pubkey)
      {:stop,:normal,:ok, %{id_pubkey: id_pubkey, certifs: [from_pubkey | certifs]}}
    end
    IO.puts(count)
    IO.puts(inspect certifs)
    {:reply, :ok, %{id_pubkey: id_pubkey, certifs: [from_pubkey | certifs]}}
  end

  def set_member(pubkey) do

    [our_id] = Repo.all(from i in Identity, where: i.pubkey ==^pubkey)
    IO.puts(inspect our_id)
    changeset = Identity.changeset(our_id,%{member: true})
    Repo.update(changeset)
    IO.puts("certified!")


  end


end
