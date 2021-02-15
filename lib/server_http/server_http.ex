defmodule ServerHttp.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger
  plug(Plug.Logger, log: :debug)

  plug(:match)

  plug(:dispatch)

  get "/node/summary" do
    json = BMA.Node.Summary.get()
    send_resp(conn, 200, json)
  end

  get "/node/sandboxes" do
    json = BMA.Node.Sandboxes.get()
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
    # TODO
    send_resp(conn, 200, "#TODO")
  end

  get "wot/lookup/:search" do
    # TODO
    json = BMA.Wot.Lookup.get(search)
    send_resp(conn, 200, json)
  end

  get "wot/members/" do
    # TODO
    json = BMA.Wot.Members.get()
    send_resp(conn, 200, json)
  end

  get "wot/requirements/:search" do
    # TODO
    json = BMA.Wot.Requirements.get(search)
    send_resp(conn, 200, json)
  end

  get "wot/requirements-of-pending/:minsig" do
    # TODO
    json = BMA.Wot.RequirementsOfPending.get(minsig)
    send_resp(conn, 200, json)
  end

  get "wot/certifiers-of/:search" do
    # TODO
    json = BMA.Wot.CertifiersOf.get(search)
    send_resp(conn, 200, json)
  end

  get "wot/certified-by/:search" do
    # TODO
    json = BMA.Wot.CertifiersBy.get(search)
    send_resp(conn, 200, json)
  end

  get "wot/identity-of/:search" do
    # TODO
    json = BMA.Wot.IdentityOf.get(search)
    send_resp(conn, 200, json)
  end

  get "blockchain/parameters/" do
    # TODO
    json = BMA.Blockchain.Parameters.get()
    send_resp(conn, 200, json)
  end

  post "blockchain/membership/" do
    # TODO
  end

  get "blockchain/memberships/:search" do
    # TODO
    json = BMA.Blockchain.Memberships.get(search)
    send_resp(conn, 200, json)
  end

  post "blockchain/block/" do
    # TODO
  end

  get "blockchain/block/:number" do
    json = BMA.Blockchain.Block.get(number)
    send_resp(conn, 200, json)
  end

  get "blockchain/blocks/:count/:from" do
    case BMA.Blockchain.Blocks.get(count, from) do
      {:ok, json} -> send_resp(conn, 200, json)
      {:ko, json} -> send_resp(conn, 404, json)
    end
  end

  get "blockchain/current/" do
    json = BMA.Blockchain.Current.get()
    send_resp(conn, 200, json)
  end

  get "blockchain/hardship/:search" do
    json = BMA.Blockchain.Hardship.get(search)
    send_resp(conn, 200, json)
  end

  get "blockchain/difficulties" do
    json = BMA.Blockchain.Difficulties.get()
    send_resp(conn, 200, json)
  end

  get "blockchain/milestones" do
    # TODO #non mentioned in the doc 
    json = BMA.Blockchain.Milestones.get()
    send_resp(conn, 200, json)
  end

  get "blockchain/milestones/:page" do
    # TODO #non mentioned in the doc
    json = BMA.Blockchain.Milestones.get(page)
    send_resp(conn, 200, json)
  end

  get "blockchain/with/newcomers" do
    json = BMA.Blockchain.With.Newcomers.get()
    send_resp(conn, 200, json)
  end

  get "blockchain/with/certs" do
    json = BMA.Blockchain.With.Certs.get()
    send_resp(conn, 200, json)
  end

  get "blockchain/with/joiners" do
    json = BMA.Blockchain.With.Joiners.get()
    send_resp(conn, 200, json)
  end

  get "blockchain/with/actives" do
    json = BMA.Blockchain.With.Actives.get()
    send_resp(conn, 200, json)
  end

  get "blockchain/with/leavers" do
    json = BMA.Blockchain.With.Leavers.get()
    send_resp(conn, 200, json)
  end

  get "blockchain/with/revoked" do
    json = BMA.Blockchain.With.Revoked.get()
    send_resp(conn, 200, json)
  end

  get "blockchain/with/excluded" do
    json = BMA.Blockchain.With.Excluded.get()
    send_resp(conn, 200, json)
  end

  get "blockchain/with/ud" do
    json = BMA.Blockchain.With.Ud.get()
    send_resp(conn, 200, json)
  end

  get "blockchain/with/tx" do
    json = BMA.Blockchain.With.Tx.get()
    send_resp(conn, 200, json)
  end

  get "blockchain/branches" do
    json = BMA.Blockchain.Branches.get()
    send_resp(conn, 200, json)
  end

  get "network/peers" do
    json = BMA.Network.Peers.get()
    send_resp(conn, 200, json)
  end

  get "network/peering/peers" do
    json = BMA.Network.Peering.Peers.get()
    send_resp(conn, 200, json)
  end

  post "network/peering/peers" do
    # TODO
  end

  get "network/peering" do
    json = BMA.Network.Peering.get()
    send_resp(conn, 200, json)
  end

  get "network/ws2p/heads" do
    json = BMA.Network.WS2P.Heads.get()
    send_resp(conn, 200, json)
  end

  get "network/ws2p/info" do
    # TODO #non mentioned in the doc
    json = BMA.Network.WS2P.Info.get()
    send_resp(conn, 200, json)
  end

  post "tx/process" do
    json = BMA.Tx.Process.get()
    send_resp(conn, 200, json)
  end

  get "tx/hash/:hash" do
    # TODO #non mentioned in the doc
    json = BMA.Tx.Hash.get(hash)
    send_resp(conn, 200, json)
  end

  get "tx/pending" do
    # TODO #non mentioned in the doc (= history/pending ?)
    json = BMA.Tx.Pending.get()
    send_resp(conn, 200, json)
  end

  get "tx/sources/:pubkey" do
    json = BMA.Tx.Sources.get(pubkey)
    send_resp(conn, 200, json)
  end

  get "tx/history/:pubkey" do
    json = BMA.Tx.History.get(pubkey)
    send_resp(conn, 200, json)
  end

  get "tx/history/:pubkey/pending" do
    json = BMA.Tx.History.Pending.get(pubkey)
    send_resp(conn, 200, json)
  end

  get "tx/history/:pubkey/blocks/:from/:to" do
    json = BMA.Tx.History.Blocks.get(pubkey, from, to)
    send_resp(conn, 200, json)
  end

  get "tx/history/:pubkey/times/:from/:to" do
    json = BMA.Tx.History.Times.get(pubkey, from, to)
    send_resp(conn, 200, json)
  end

  get "ud/history/:pubkey" do
    json = BMA.Ud.History.get(pubkey)
    send_resp(conn, 200, json)
  end

  get "ud/history/:pubkey/blocks/:from/:to" do
    # TODO #non mentioned in the doc
    json = BMA.Ud.History.Blocks.get(pubkey, from, to)
    send_resp(conn, 200, json)
  end

  get "ud/history/:pubkey/times/:from/:to" do
    # TODO #non mentioned in the doc
    json = BMA.Ud.History.Times.get(pubkey, from, to)
    send_resp(conn, 200, json)
  end

  # I'm not sure about the last ones, more linked with ws2p
  get "ws/block" do
    # TODO 
  end

  get "ws/peer" do
    # TODO
  end

  get "ws/head" do
    # TODO #non mentioned in the doc
  end

  # "Default" route that will get called when no other route is matched

  match _ do
    send_resp(conn, 404, "not found")
  end
end
