defmodule Crypto do
  @moduledoc """
  A module that does all cryptography in dunixir
  """

  @doc """
  This function is called when we do sync

  Example:
  iex(1)> Crypto.generate_keypair()
  {"3wuHTfP13dHLv6DbVeeuKPk5hxGycnAVyc8SyGwWsAqQjzxyxfpLvMBiTcEB8BhfWmuPEkpSbAN3h8BUQMcoSjW9",
  "DAeiD5TEYWop9Wk4mRB8h9Jpc9XLiiuBHsnTm1jhSXDK"}
  """
  def generate_keypair() do
    # generate a 32 size seed
    seed = gen_random_bytes(32)
    # get keypair from the seed
    keypair(seed)
  end

  defp keypair(seed) do
    key_pair = :enacl.sign_seed_keypair(seed)
    {base58_encode(key_pair.secret), base58_encode(key_pair.public)}
  end

  @doc """
  Generates a seed from password and salt

  Example:
  iex(3)> Crypto.gen_seed("dafdsih","dghbeb")
  "J4AV75QY7AYdcD7NtghZmAAx9HpjkXB9XzkfWEposkTS"
  """
  def gen_seed(password, salt) do
    # hash(password, salt, log_n, r, p, key_length)
    raw_seed = Scrypt.hash(password, salt, 12, 16, 1, 32)
    {seed, _pub} = Ed25519.generate_key_pair(raw_seed)
    base58_encode(seed)
  end

  @doc """
  Generate a keypair from the salt and password offered by user

  Example:
  iex(2)> Crypto.generate_keypair_with_seed("123","abc")
  {"4Q4ztZC5izDhW4JvipBhoKEdt4wjTHEULZg3aQekWapwLs5zXtGGnu7EyZJXpaWRspyc9tWyvWHsV3pvD3QifM8d",
  "3kqxHEV8qZgA8NgVDZAydQVXdWaq1FGaheg6GgtHZMNy"}
  """
  def generate_keypair_with_seed(password, salt) do
    seed = gen_seed(password, salt)
    keypair(base58_decode(seed))
  end

  def gen_ed25519_keypair_with_base58() do
    # return : {secret_key, public_key}
    {sec_key, pub_key} = Ed25519.generate_key_pair()
    {base58_encode(sec_key), base58_encode(pub_key)}
  end

  def hash_sha256(data) do
    :crypto.hash(:sha256, data) |> Base.encode64()
  end

  def base58_encode(data) do
    Base58.encode(data)
  end

  def base58_decode(data) do
    Base58.decode(data)
  end

  def gen_random_bytes(size) do
    :crypto.strong_rand_bytes(size)
  end


  @doc """
      Sign a message with secret key

      Example:
      iex(1)>  {sec, pub} = Crypto.gen_ed25519_keypair_with_base64()
      {<<187, 92, 206, 176, 77, 109, 208, 238, 62, 13, 42, 56, 170, 28, 99, 237, 131,
        27, 29, 135, 66, 40, 148, 36, 153, 237, 10, 102, 167, 183, 190, 102>>,
      <<177, 85, 206, 200, 39, 193, 52, 198, 98, 216, 245, 106, 171, 122, 19, 217,
        221, 64, 168, 131, 224, 12, 110, 30, 164, 113, 104, 157, 45, 14, 99, 46>>}
      iex(2)> signature = Crypto.sign_message_with_ed25519("Elixir is the best language", sec)
      "z940JmXFuou9+y7smER5QXJ3KhlhSNkLWBCvDJUBgxS0wRh5lWLQT5MBL+F+oD4D8bD9nu3VXssJHD5wmzT3DA=="
  """
  def sign_message_with_ed25519(message, seckey) do
    # sign message from personal sec key, how can we get sec key safely?
    # TODO: figure out how to access to secret key safely
    Ed25519.signature(message, base58_decode(seckey)) |> Base.encode64()
  end

  @doc """
      Verified a signature with the original message and its corresponded public key

      Example: (pub and signature are based on the example of function sign_message_with_ed25519)
      iex(4)>Crypto.verify_signature(signature, "Elixir is the best language", pub)
      true
  """
  def verify_signature(signature, message, pubkey) do
    Ed25519.valid_signature?(Base.decode64!(signature), message, base58_decode(pubkey))
  end
end
