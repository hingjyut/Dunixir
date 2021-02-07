defmodule WS2P.Cluster.Test do
  use ExUnit.Case
  doctest Dunixir


  @received_msg  %{
    "body" => %{
      "heads" => [
        %{
          "message" => "WS2POCAIC:HEAD:1:HAy1hLpHfqrG3xsZRoBVkNigGQZnDfJK2az5MeRYtyNb:694027-0000988886FA69E41386B0E992B66DB4FE77BA4A5B29B5BBD04F85DFEDC80CF3:c4df202c:duniter:1.8.1:1",
          "messageV2" => "WS2POCAIC:HEAD:2:HAy1hLpHfqrG3xsZRoBVkNigGQZnDfJK2az5MeRYtyNb:694027-0000988886FA69E41386B0E992B66DB4FE77BA4A5B29B5BBD04F85DFEDC80CF3:c4df202c:duniter:1.8.1:1:9:9",
          "sig" => "FyUd1YZPFK483p9xJDveDeSPDQUYlr90FEgXDuxGajfc7t7pw7L2zEV/In0zTNX4O+hT8Otan2HTKw//JbkzCQ==",
          "sigV2" => "GZgbXaVUKrFAg4iTYqh9EqmUg0yr/aZeeLEmuT2i9IFK9OBc+3LwdqbYdIdg9dcl3XwdbAFzkkV6qNqip2iCDg==",
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

"""
{:ok, pid} = GenServer.start_link(WS2P.Cluster, [])
heads = %{
  "message" => "WS2POCAIC:HEAD:1:HAy1hLpHfqrG3xsZRoBVkNigGQZnDfJK2az5MeRYtyNb:694027-0000988886FA69E41386B0E992B66DB4FE77BA4A5B29B5BBD04F85DFEDC80CF3:c4df202c:duniter:1.8.1:1",
  "messageV2" => "WS2POCAIC:HEAD:2:HAy1hLpHfqrG3xsZRoBVkNigGQZnDfJK2az5MeRYtyNb:694027-0000988886FA69E41386B0E992B66DB4FE77BA4A5B29B5BBD04F85DFEDC80CF3:c4df202c:duniter:1.8.1:1:9:9",
  "sig" => "FyUd1YZPFK483p9xJDveDeSPDQUYlr90FEgXDuxGajfc7t7pw7L2zEV/In0zTNX4O+hT8Otan2HTKw//JbkzCQ==",
  "sigV2" => "GZgbXaVUKrFAg4iTYqh9EqmUg0yr/aZeeLEmuT2i9IFK9OBc+3LwdqbYdIdg9dcl3XwdbAFzkkV6qNqip2iCDg==",
  "step" => 2
}
GenServer.call(pid, heads)


"""
