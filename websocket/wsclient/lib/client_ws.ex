defmodule ClientWs do
  use WebSockex

  def start(_type, _args) do
    @doc """
    Some codes about checking endpoints' regexp

    ## Codes begin

    # the client will recevie an endpoint from somewhere, we can put this endpoint as default for now
    endpoint = "WS2P a0a45ed2 88.174.120.187 20901"
    # if this endpoint matches the regexp, we start to connect to duniter
    # TODO: there are two types of endpoints, I have only implemented one of them
    if String.match?(endpoint, ~r/^WS2P (?:[1-9][0-9]* )?([a-f0-9]{8}) ([a-z_][a-z0-9-_.]*|[0-9.]+|[0-9a-f:]+) ([0-9]+)(?: (.+))?$/) do
      [_api, _uuid, host, port] = String.split(endpoint, " ")
      url = "ws://#{host}:#{port}"
      {:ok,spid} = WebSockex.start_link(url,__MODULE__,:ok)
    else
      IO.puts "Invalid endpoint#{endpoint}"
    end

    ## Codes end
    
    """
    {:ok,spid} = WebSockex.start_link("ws://localhost:4000/ws/chat",__MODULE__,:ok)
    WebSockex.send_frame(spid,{:text,"hello"})
    {:ok,spid}
  end

  def handle_frame({:text,text},state) do
    IO.inspect(text);
    {:ok,state}
  end
end
