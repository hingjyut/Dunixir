defmodule SimpleServer.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger
  import Ecto.Query
  plug(Plug.Logger, log: :debug)


  plug(:match)

  plug(:dispatch)


  # TODO: add routes

  get "/node/summary" do
    json = Poison.encode!(
      %{duniter:
        %{software: "duniter",
        version: Constants.version,
        forkWindowSize: Constants.forkWindowSize
        }
      }
    )
    send_resp(conn, 200, json)
  end

  get "/node/sandboxes" do
    #IO.puts(Constants.version)
    id_sbx_count = Duniter.Identity.ToProcess |> Repo.all |> Enum.count
    json = Poison.encode!(
      %{transactions:
          %{size: Constants.sandboxTxSize, free: nil} ,
        identities:
          %{size: Constants.sandboxIdSize, free: Constants.sandboxIdSize - id_sbx_count},
        membership:
          %{size: Constants.sandboxMemberSize, free: nil}
      }
    )
    send_resp(conn, 200, json)
  end

  # Basic example to handle POST requests wiht a JSON body
  post "/wot/add" do

    {:ok, body, conn} = read_body(conn)
    body = Poison.decode!(body)
    id = %Identity{uid: body["uid"], pubkey: body["pubkey"], member: body["member"]}
    Repo.insert(id)
    {:ok,child} = DynamicSupervisor.start_child(Identity.DynamicSupervisor, %{id: body["pubkey"], start: {IDGenserver, :start, [body["pubkey"]]}})

    #Duniter.Identity |> Duniter.Repo.all
    send_resp(conn, 201, "created: #{inspect id}")

  end

  post "wot/certify" do

    {:ok, body, conn} = read_body(conn)
    body = Poison.decode!(body)
    our_id = Repo.all(from i in Identity, where: i.pubkey == ^body["pubkey"], select: i.member)
    case our_id do
      [] -> send_resp(conn, 301, "error: ID does not exist")
      [true] ->  send_resp(conn, 301, "error: ID is already a member")
      _ ->
        cert = %Certification{uid: body["uid"], pubkey: body["pubkey"], from_pubkey: body["from_pubkey"], written: body["written"]}
        Repo.insert(cert)
        {:ok, pid} = IDGenserver.start(body["pubkey"])
        GenServer.call(pid, {:certify, %{"from_pubkey" => body["from_pubkey"]}}, 20_000)
        send_resp(conn, 201, "created: #{inspect cert}")
    end


  end


  # "Default" route that will get called when no other route is matched

  match _ do

    send_resp(conn, 404, "not found")

  end
end
