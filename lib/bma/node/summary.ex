defmodule BMA.Node.Summary do
    def get do
    Poison.encode!(
      %{duniter:
        %{software: "duniter",
        version: Constant.version,
        forkWindowSize: Constant.forkWindowSize
        }})
    end
end
