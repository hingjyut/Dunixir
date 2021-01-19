defmodule Block.Validation.Local.TxSigOrdered do
  def valid(block) do
    valid_tx(block["transactions"])
  end

  def valid_tx([]) do
    true
  end
  def valid_tx([hd | tl]) do
    valid_signatures(hd["signatures"], get_raw(hd), hd["issuers"]) and valid_tx(tl)
  end

  def valid_signatures([], _raw, []) do
    true
  end
  def valid_signatures([], _raw, [_hd | _tl]) do
    false
  end
  def valid_signatures([_hd | _tl], _raw, []) do
    false
  end
  def valid_signatures([hds | tls], raw, [hdi | tli]) do
    try do  # Certain values for the signature seem to crash verify_signature
      Crypto.verify_digital_signature(hds, raw, hdi) and valid_signatures(tls, raw, tli)
    rescue  # If this happens, the signature is not correct
      _ -> false
    end
  end

  def get_raw(tx) do
    "Version: #{tx["version"]}\n"
    <>"Type: Transaction\n"
    <>"Currency: #{tx["currency"]}\n"
    <>"Blockstamp: #{tx["blockstamp"]}\n"
    <>"Locktime: #{tx["locktime"]}\n"
    <>"Issuers:\n"
    <>add_list(tx["issuers"])
    <>"Inputs:\n"
    <>add_list(tx["inputs"])
    <>"Unlocks:\n"
    <>add_list(tx["unlocks"])
    <>"Outputs:\n"
    <>add_list(tx["outputs"])
    <>"Comment: #{tx["comment"]}\n"
  end

  def add_list([]) do
    ""
  end
  def add_list([hd | tl]) do
    hd <> "\n" <> add_list(tl)
  end

end
