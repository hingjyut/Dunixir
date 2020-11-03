defmodule Restarter do
  import Ecto.Query
  # Routine to restart all the genservers of the identity sandbox
  def start() do
    query = from i in "sandbox_idty",
          select: i.pubkey
    ids_to_start = query |> Repo.all
    for x <- ids_to_start do
      IDGenserver.start(x)
    end
    IO.puts(inspect ids_to_start)
    {:ok,self()}
  end

end
