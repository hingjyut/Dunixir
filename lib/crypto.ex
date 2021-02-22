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

  Sign message with private key

  Input:
  message: string
  secret key: a string which length is equal to 64

  Output:
  A signature written under Base64 encoding

  Example:
  iex(1)> {seckey, pubkey} = Crypto.generate_keypair()
  {"63FrkQLfT1vxvQpA7b1WuzMH1RBYN55sqnHsjRmVXDhGqmE9m5An5acpWaZAQjtjP3Z26frR5URnjyjs8MUd1hV",
  "CRJeqbTkr5LUqnpWZAFnzoSUUyfajNF87rjXvLQHm123"}
  iex(2)> message = "hello world"
  "hello world"
  iex(3)> signature = Crypto.digital_signature(message, seckey)
  "1O1AYlvH/ub174RVXn+ia3ZImOS6yWg+GBkgb1b3d5XvkxgLWAclo+esLDDhSkaz9NDCA+9Xs8bVE8FLBBUHBQ=="

  """

  def digital_signature(message, seckey) do
    # TODO: figure out how to access to secret key safely
    :enacl.sign_detached(message, base58_decode(seckey)) |> Base.encode64()
  end

  @doc """
  Verify signature

  Example: Based on the previous simulation in digital_signature(message, seckey) example
  ex(4)> signature = Crypto.verify_digital_signature(signature, message, pubkey)
  true
  """

  def verify_digital_signature(signature, message, pubkey) do
    :enacl.sign_verify_detached(Base.decode64!(signature), message, base58_decode(pubkey))
  end
end
