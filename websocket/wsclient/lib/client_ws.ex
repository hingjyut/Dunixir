defmodule ClientWs do
  use WebSockex

  def start(_type, _args) do
    {:ok,spid} = WebSockex.start_link("ws://localhost:4000/ws/chat",__MODULE__,:ok)
    WebSockex.send_frame(spid,{:text,"hello"})
    {:ok,spid}
  end
  def handle_frame({:text,text},state) do
    IO.inspect(text);
    {:ok,state}
  end
end
