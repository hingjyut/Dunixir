defmodule MyWebsocketApp.Test do
  use ExUnit.Case, async: true
  doctest MyWebsocketApp

  setup do
    connection =
      start_supervised!({WS2P.Connection, {:connect, {"g1-test.duniter.org", 20901}, "/"}})

    %{connection: connection}
  end

  test "receives CONNECT from g1-test.duniter.org", %{connection: connection} do
    {received_object, :noanswer} = WS2P.Connection.receive_object(connection)
    assert Map.has_key?(received_object, "auth")
    assert received_object["auth"] == "CONNECT"
  end
end
