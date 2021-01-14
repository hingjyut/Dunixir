defmodule BDD do 

    require Logger
    
    @base_url 'https://g1-test.duniter.org/blockchain/blocks/'
  
    @doc """
    Create some of the needeed dets table after checking if they already exist
    """
    def create_if_not_created do 
        if not File.dir?('data') do
            File.mkdir('data')
            :dets.open_file(:global_iindex , [{:file, 'data/global_iindex'} , {:type, :set}])
            :dets.open_file(:global_bindex , [{:file, 'data/global_bindex'} , {:type, :set}])
            :dets.open_file(:global_mindex , [{:file, 'data/global_mindex'} , {:type, :set}])
            :dets.open_file(:global_cindex , [{:file, 'data/global_cindex'} , {:type, :set}])
            :dets.open_file(:global_sindex , [{:file, 'data/global_sindex'} , {:type, :set}])
            :dets.open_file(:block , [{:file, 'data/block'} , {:type, :set}])
        else 
            if not File.exists?('data/block') do
                :dets.open_file(:block , [{:file, 'data/block'} , {:type, :set}])
            end
            if not File.exists?('data/global_iindex') do
                :dets.open_file(:global_iindex , [{:file, 'data/global_iindex'} , {:type, :set}])
            end
            if not File.exists?('data/global_bindex') do
                :dets.open_file(:global_bindex , [{:file, 'data/global_bindex'} , {:type, :set}])
            end
            if not File.exists?('data/global_sindex') do
                :dets.open_file(:global_sindex , [{:file, 'data/global_sindex'} , {:type, :set}])
            end
            if not File.exists?('data/global_cindex') do
                :dets.open_file(:global_cindex , [{:file, 'data/global_cindex'} , {:type, :set}])
            end
            if not File.exists?('data/global_mindex') do
                :dets.open_file(:global_mindex , [{:file, 'data/global_mindex'} , {:type, :set}])
            end
        end
    end

    @doc """
    Insert in the block dets table the n fisrt block of the bockchain, get throught an http request    
    """    
    def fill_with_block(n) do
        {:ok , :block} = :dets.open_file(:block , [{:file, 'data/block'} , {:type, :set}])
        case :httpc.request(:get, {@base_url ++ to_charlist(n) ++ '/0', []}, [], []) do
            {:ok, resp}        ->
                Logger.info('data received')
                case resp do
                    {{_, 200, 'OK'}, _headers, '[]'}
                        -> Logger.info('---DONE---')
                    {{_, 200, 'OK'}, _headers, body}
                        -> Poison.decode!(body) |> Enum.map( fn b -> :dets.insert(:block, { b["number"], b }) end)
                    _ -> Logger.info('---Failed---')
                end
            end
    end 
end

defmodule BDD.Create do 
    use GenServer
    def start_link(arg) do GenServer.start_link(__MODULE__,arg,name: __MODULE__) end
    def init(_) do
        BDD.create_if_not_created
        BDD.fill_with_block(50)
        {:ok , nil}
    end
end