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

    id_sbx_count = Identity.ToProcess |> Repo.all |> Enum.count

    # The sandbox of the identities is the identities not confirmed yet, represented in the view Identity.ToProcess

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

  post "/wot/add" do

    {:ok, body, conn} = read_body(conn)
    body = Poison.decode!(body)
    changeset = Identity.changeset(%Identity{},%{uid: body["uid"], pubkey: body["pubkey"], member: body["member"]})
    result = Repo.insert(changeset)
    case result do

      {:error,changeset} -> send_resp(conn, 301, "failed creation: #{inspect changeset}")

      _ ->

        DynamicSupervisor.start_child(Identity.DynamicSupervisor, %{id: body["pubkey"], start: {IDGenserver, :start, [body["pubkey"]]}})

        # We insert the Identity in the db and start the genserver that will its certifications.

        send_resp(conn, 201, "created: #{inspect changeset}")
    end


  end

  post "wot/certify" do

    {:ok, body, conn} = read_body(conn)
    body = Poison.decode!(body)
    membership = Repo.all(from i in Identity, where: i.pubkey == ^body["pubkey"], select: i.member)
    case membership do

      [] -> send_resp(conn, 301, "error: ID does not exist") # If the query response is empty, the Identity doesn't exist

      [true] ->  send_resp(conn, 301, "error: ID is already a member") # else if it is true, the Identity is already a member

      _ -> # else we call the GenServer associated with the pubkey we certify and add a certification to its state.
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
