defmodule HeadsTest do
  use ExUnit.Case
  doctest Dunixir


  @head  %{
            "message": "WS2POCAIC:HEAD:1:5B8iMAzq1dNmFe3ZxFTBQkqhq4fsztg1gZvxHXCk1XYH:690994-0000286014E9647880B606D480599BD451352901899BBE5DE295A06776189F8E:2bbc5904:duniter:1.8.1:1",
            "sig": "ZpUNqelhd7ckgf4idP/oFldkLzx6jbfKY5ZhvXL6A2x0Zw/iQ5Id1vg3bMqu7Fp6FnKrPB69ObB4k9TQ/WCDDA==",
            "messageV2": "WS2POCAIC:HEAD:2:5B8iMAzq1dNmFe3ZxFTBQkqhq4fsztg1gZvxHXCk1XYH:690994-0000286014E9647880B606D480599BD451352901899BBE5DE295A06776189F8E:2bbc5904:duniter:1.8.1:1:20:20",
            "sigV2": "ioHJ3XoxMMYSJcZZnrT6CqKAnBZim6dre/kc21LQL635cjecUSZmAicaaWygvnc2l6rO/Swt8gCYCLPnMs9zCw==",
            "step": 1
            } #Get this head from https://g1-test.duniter.org/network/ws2p/heads


  test "test head v1" do
    head = @head
    assert WS2P.CheckHeads.check_head_v1(%{message: head.message, sig: head.sig})
  end

  test "test head v2" do
    head = @head
    assert WS2P.CheckHeads.check_head_v2(%{messageV2: head.messageV2, sigV2: head.sigV2})
  end

end
