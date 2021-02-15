defmodule Block.Validation.Local.InnerHash do
  def valid(block) do
    computed_hash =
      :crypto.hash(:sha256, _get_raw_inner_part(block))
      |> Base.encode16()
      |> String.upcase()

    computed_hash == block["inner_hash"]
  end

  @doc """
  Convert the given `list` into suitable format for hashing

  Concat a '\n' at the end of each element from `list` and joins the table.

  Returns: string 
  """
  def _string_of_list(list) do
    (list || [])
    |> Enum.map(fn i -> i <> "\n" end)
    |> Enum.join()
  end

  @doc """
  Prepare given `block` for hashing and return computed string

  Returns: string
  """
  def _get_raw_inner_part(block) do
    """
    Version: #{block["version"]}
    Type: Block
    Currency: #{block["currency"]}
    Number: #{block["number"]}
    PoWMin: #{block["powMin"]}
    Time: #{block["time"]}
    MedianTime: #{block["medianTime"]}
    #{
      if block["dividend"] do
        "UniversalDividend: #{block["dividend"]}\n"
      end
    }\
    UnitBase: #{block["unitBase"]}
    Issuer: #{block["issuer"]}
    IssuersFrame: #{block["issuersFrame"]}
    IssuersFrameVar: #{block["issuersFrameVar"]}
    DifferentIssuersCount: #{block["issuersCount"]}
    #{
      if block["previousHash"] do
        "PreviousHash: #{block["previousHash"]}\n"
      end
    }\
    #{
      if block["previousIssuer"] do
        "PreviousIssuer: #{block["previousIssuer"]}\n"
      end
    }\
    #{
      if block["parameters"] do
        "Parameters: #{block["parameters"]}\n"
      end
    }\
    MembersCount: #{block["membersCount"]}
    Identities:
    #{_string_of_list(block["identities"])}\
    Joiners:
    #{_string_of_list(block["joiners"])}\
    Actives:
    #{_string_of_list(block["actives"])}\
    Leavers:
    #{_string_of_list(block["leavers"])}\
    Revoked:
    #{_string_of_list(block["revoked"])}\
    Excluded:
    #{_string_of_list(block["excluded"])}\
    Certifications:
    #{_string_of_list(block["certifications"])}\
    Transactions:
    #{_string_of_list(block["transactions"])}\
    """
  end
end
