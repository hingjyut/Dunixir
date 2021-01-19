defmodule Block.Validation.Local.TxSigOrdered do
  def valid(block) do
    _valid_tx(block["transactions"])
  end

  @doc """
  Validates a list of transactions
  returns boolean
  """
  def _valid_tx([]) do
    true
  end
  def _valid_tx([hd | tl]) do
    _valid_signatures(hd["signatures"], _get_raw(hd), hd["issuers"]) and _valid_tx(tl)
  end

  @doc """
  Validates a list of signatures
  returns boolean
  """
  def _valid_signatures([], _raw, []) do
    true
  end
  def _valid_signatures([], _raw, [_hd | _tl]) do
    false
  end
  def _valid_signatures([_hd | _tl], _raw, []) do
    false
  end
  def _valid_signatures([hds | tls], raw, [hdi | tli]) do
    Crypto.verify_digital_signature(hds, raw, hdi) and _valid_signatures(tls, raw, tli)
  end

  @doc """
  Returns the raw corresponding to the transaction
  returns string
  """
  def _get_raw(tx) do
    "Version: #{tx["version"]}\n"
    <>"Type: Transaction\n"
    <>"Currency: #{tx["currency"]}\n"
    <>"Blockstamp: #{tx["blockstamp"]}\n"
    <>"Locktime: #{tx["locktime"]}\n"
    <>"Issuers:\n"
    <>_add_list(tx["issuers"])
    <>"Inputs:\n"
    <>_add_list(tx["inputs"])
    <>"Unlocks:\n"
    <>_add_list(tx["unlocks"])
    <>"Outputs:\n"
    <>_add_list(tx["outputs"])
    <>"Comment: #{tx["comment"]}\n"
  end

  @doc """
  Generates a string from the list of elements
  returns string
  """
  def _add_list([]) do
    ""
  end
  def _add_list([hd | tl]) do
    hd <> "\n" <> _add_list(tl)
  end

end
