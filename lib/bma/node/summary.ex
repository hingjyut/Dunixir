defmodule BMA.Node.Summary do
  def get do
    Poison.encode!(%{
      duniter: %{
        software: "duniter",
        version: Constants.version(),
        forkWindowSize: Constants.forkWindowSize()
      }
    })
  end
end
