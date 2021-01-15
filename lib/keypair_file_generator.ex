defmodule KeypairFileGenerator do
    require Logger
    @filename "data/keypair.yml"
    def generate_file_if_nonexistent do
        if File.exists?(@filename) do
            Logger.info("Keypair file existed")
            {:noreply, "Don't generate new keypair"}
        else
            # generate keypair
            {pub, sec} = Crypto.generate_keypair()
            # reformulate it
            keypair = %{pub: pub, sec: sec}
            Logger.info("Generated a random keypair for this node, storing them into keypair.yml")
            File.write!(@filename,  Ymlr.document!(keypair))
        end
    end
end
