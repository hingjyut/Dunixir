defmodule ServerHttp.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger
  plug(Plug.Logger, log: :debug)


  plug(:match)

  plug(:dispatch)

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

    json = Poison.encode!(
      "#TODO"
    )
    send_resp(conn, 200, json)
  end

  post "/wot/add" do

    {:ok, body, conn} = read_body(conn)
    body = Poison.decode!(body)
    send_resp(conn, 200, "#TODO")
  end

  post "wot/certify" do

    {:ok, body, conn} = read_body(conn)
    body = Poison.decode!(body)
    send_resp(conn, 200, "#TODO")
  end

  post "wot/revoke" do 
    #TODO
    send_resp(conn, 200, "#TODO")
  end

  get "wot/lookup/:search" do 
    #TODO
    send_resp(conn, 200, "#TODO")
  end

  get "wot/members/" do 
    #TODO
    send_resp(conn, 200, "#TODO")
  end

  get "wot/requirements/:search" do 
    #TODO
  end

  get "wot/requirements-of-pending/:minsig" do 
    #TODO
  end

  get "wot/certifiers-of/:search" do 
    #TODO
  end

  get "wot/certified-by/:search" do 
    #TODO
  end

  get "wot/identity-of/:search" do 
    #TODO
  end

  get "blockchain/parameters/" do 
    #TODO
  end

  post "blockchain/membership/" do 
    #TODO
  end

  get "blockchain/memberships/:search" do 
    #TODO
  end

  post "blockchain/block/" do 
    #TODO
  end

  get "blockchain/block/:number" do 
    #TODO
  end

  get "blockchain/blocks/:count/:from" do 
    #TODO
  end
 
  get "blockchain/current/" do 
    #TODO
  end 

  get "blockchain/hardship/:search" do 
    #TODO
  end

  get "blockchain/difficulties/" do 
    #TODO
  end

  get "blockchain/milestones" do 
    #TODO #non mentioned in the doc 
  end

  get "blockchain/milestones/:page" do 
    #TODO #non mentioned in the doc
  end

  get "blockchain/with/newcomers" do 
    #TODO
  end

  get "blockchain/with/certs" do 
    #TODO
  end

  get "blockchain/with/joiners" do 
    #TODO
  end

  get "blockchain/with/actives" do 
    #TODO
  end

  get "blockchain/with/leavers" do 
    #TODO
  end

  get "blockchain/with/revoked" do 
    #TODO
  end

  get "blockchain/with/excluded" do 
    #TODO
  end

  get "blockchain/with/ud" do 
    #TODO
  end

  get "blockchain/with/tx" do 
    #TODO
  end

  get "blockchain/branches" do 
    #TODO
  end

  get "network/peers" do 
    #TODO
  end

  get "network/peering/peers" do 
    #TODO
  end

  post "network/peering/peers" do 
    #TODO
  end

  get "network/peering" do 
    #TODO
  end

  get "network/ws2p/heads" do 
    #TODO
  end

  get "network/ws2p/info" do 
    #TODO #non mentioned in the doc
  end

  post "tx/process" do 
    #TODO
  end

  get "tx/hash/:hash" do 
    #TODO #non mentioned in the doc
  end

  get "tx/pending" do 
    #TODO #non mentioned in the doc (= history/pending ?)
  end

  get "tx/sources/:pubkey" do 
    #TODO
  end

  get "tx/history/:pubkey" do 
    #TODO
  end

  get "tx/history/:pubkey/pending" do 
    #TODO
  end

  get "tx/history/:pubkey/blocks/:from/:to" do 
    #TODO
  end

  get "tx/history/:pubkey/times/:from/:to" do 
    #TODO
  end

  get "ud/history/:pubkey" do 
    #TODO
  end

  get "ud/history/:pubkey/block/:from/:to" do 
    #TODO #non mentioned in the doc
  end

  get "ud/history/:pubkey/times/:from/:to" do 
    #TODO #non mentioned in the doc
  end

  #I'm not sure about the last ones, more linked with ws2p
  get "ws/block" do 
    #TODO 
  end

  get "ws/peer" do 
    #TODO
  end

  get "ws/head" do 
    #TODO #non mentioned in the doc
  end

  # "Default" route that will get called when no other route is matched

  match _ do

    send_resp(conn, 404, "not found")

  end
end
