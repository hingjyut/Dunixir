defmodule Block.Validation.Local.TxInfNbIssuers do
  def valid(block) do
    case block["transactions"] do
      nil -> true # Since there is no transaction field, there is no transaction to check
      transactions -> _checkTxList(transactions)
    end
  end

  @doc """
  Checks every element in a list of transaction to make sure they are all valid
  """
  def _checkTxList([]) do # No transaction to check
    true
  end
  def _checkTxList([tx | tail]) do # We have a list of transactions
    _checkTx(tx) and _checkTxList(tail) # We need to check the first transaction and the rest of the transactions
  end

  @doc """
  Checks and validates a single transaction
  """
  def _checkTx(tx) do
    issuerCount = Enum.count(tx["issuers"])
    to_unlock = tx["unlocks"]
    _checkUnlocks(issuerCount, to_unlock)
  end

  @doc """
  Checks every unlock is below the number of issuers
  """
  def _checkUnlocks(_issuerCount, []) do
    true
  end
  def _checkUnlocks(issuerCount, [unlock | tail]) do
    (_getSIGValue(unlock) <= issuerCount - 1) and _checkUnlocks(issuerCount, tail)
  end

  @doc """
  Returns the number between the brackets
  """
  def _getSIGValue(str) do
    String.to_integer(Enum.at(String.split(str, ["(", ")"]), 1))
  end

end
