defmodule Block.Validation.Local.ProofOfWork do
  def valid(block) do
    required_zeros = div(block["powMin"], 16)
    String.match?(block["hash"], ~r/^0{#{required_zeros}}/)
  end
end
