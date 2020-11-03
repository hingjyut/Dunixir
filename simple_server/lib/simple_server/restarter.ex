defmodule Restarter do
  import Ecto.Query

  def start() do
    query = from i in "identities",
          where: i.member == false,
          select: i.pubkey
    ids_to_start = query |> Repo.all
    for x <- ids_to_start do
      IDGenserver.start(x)
    end
    IO.puts(inspect ids_to_start)
    {:ok,self()}
  end

end
