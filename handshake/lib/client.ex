defmodule Handshake.Client do
  use WebSockex

  @moduledoc """
  Documentation for Handshake.Client.
  """

  def start_link(url, state) do
    WebSockex.start_link(url, __MODULE__, state)
  end

  @doc """
  Hello world.

  ## Examples

      iex> Handshake.hello()
      :world

  """
  def hello do
    :world
  end
end
