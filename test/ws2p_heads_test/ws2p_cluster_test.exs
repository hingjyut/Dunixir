defmodule WS2P.Cluster.Test do
  use ExUnit.Case
  doctest Dunixir

  @received_msg %{
    "body" => %{
      "heads" => [
        %{
          "message" =>
            "WS2POCAIC:HEAD:1:HAy1hLpHfqrG3xsZRoBVkNigGQZnDfJK2az5MeRYtyNb:694027-0000988886FA69E41386B0E992B66DB4FE77BA4A5B29B5BBD04F85DFEDC80CF3:c4df202c:duniter:1.8.1:1",
          "messageV2" =>
            "WS2POCAIC:HEAD:2:HAy1hLpHfqrG3xsZRoBVkNigGQZnDfJK2az5MeRYtyNb:694027-0000988886FA69E41386B0E992B66DB4FE77BA4A5B29B5BBD04F85DFEDC80CF3:c4df202c:duniter:1.8.1:1:9:9",
          "sig" =>
            "FyUd1YZPFK483p9xJDveDeSPDQUYlr90FEgXDuxGajfc7t7pw7L2zEV/In0zTNX4O+hT8Otan2HTKw//JbkzCQ==",
          "sigV2" =>
            "GZgbXaVUKrFAg4iTYqh9EqmUg0yr/aZeeLEmuT2i9IFK9OBc+3LwdqbYdIdg9dcl3XwdbAFzkkV6qNqip2iCDg==",
          "step" => 2
        },
        %{
          "message" =>
            "WS2POCAIC:HEAD:1:3bGqhAELTU1R1br31Nmk9pt2oaAY3GL2ZwSWWjm7peeK:396970-0000000F49B173115846C603759633AD7E1B671C2A8AA50C4E9610290D0FFDD3:a87f1553:duniter:1.8.1:2",
          "sig" =>
            "8WzWMyJH1me5JTHfMK8mAsN+WA9mJNpCh2vEOxfegkgymk6yltrMDi4L5V8kbhhTMiAiNk8CqAs1CNuksba2CQ==",
          "messageV2" =>
            "WS2POCAIC:HEAD:2:3bGqhAELTU1R1br31Nmk9pt2oaAY3GL2ZwSWWjm7peeK:396970-0000000F49B173115846C603759633AD7E1B671C2A8AA50C4E9610290D0FFDD3:a87f1553:duniter:1.8.1:2:46:46",
          "sigV2" =>
            "gQ8WV8LnZxCt1vTgQT7+9c+7YRqUWYoBsTIpBP23oFkadUGIhNmDaKoZwSx0aG5p5b3w/PagZ3vENO0UGFfaBw==",
          "step" => 2
        }
      ],
      "name" => "HEAD"
    }
  }

  test "send heads to cluster" do
    receivd_msg = @received_msg

    if receivd_msg["body"]["name"] == "HEAD" do
      to_be_sent_heads = receivd_msg["body"]["heads"]
      # IO.inspect( to_be_sent_heads )
      {:ok, pid} = GenServer.start_link(WS2P.Cluster, [])
      new_valid_heads = GenServer.call(pid, {:heads_received, to_be_sent_heads})
      IO.inspect(new_valid_heads)
    end
  end
end
