defmodule CryptoTest do
  use ExUnit.Case, async: true
  doctest Dunixir

  test "generate a keypair with salt and password" do
    salt = "I'm not sweet"
    password = "Je m'appelle le mot de passe"
    # Get this keypair from this website: https://gsper.duniter.io/dunikey.html
    priv_key =
      "5mMALpffsCVYqBC7suqAc1ffKEU2sTYaUY9WpjS3k1oe5qyLESwyEVjMXy9MgTgd7fyTiV3ryRFXLhpii7Y8QfPG"

<<<<<<< HEAD
    test "test signature function" do
      message = "Gimme 1000gt"
      {seckey, pubkey} = Crypto.generate_keypair()
      signature = Crypto.digital_signature(message, seckey)
      assert Crypto.verify_digital_signature(signature, message, pubkey)
    end
=======
    pub_key = "8WUg3M26sPbGq8NonKXNKS6S7qJdCxwabFnBqv54aQLi"
    {priv_key_test, pub_key_test} = Crypto.generate_keypair_with_seed(password, salt)
    assert priv_key_test == priv_key
    assert pub_key_test == pub_key
  end

  test "test signature function" do
    message = "Gimme 1000gt"
    {seckey, pubkey} = Crypto.generate_keypair()
    signature = Crypto.digital_signature(message, seckey)
    assert signature = Crypto.verify_digital_signature(signature, message, pubkey)
  end
>>>>>>> origin/dev
end
