
# ServerHTTP
Simple HTTP elixir server designed for the BMA (basic Merkle API) of duniter (nswers to some Duniter HTTP requests, testing database manipulations and a beginning of processing distribution).


# To start : 

mix deps.get
iex -S mix

# Send requests

in a shell :
for a http get method : 
curl -v "http adress"
example :
curl -v "http://localhost:8085/node/summary"
curl -v "http://localhost:8085/node/sandboxes"

for a http post method :
curl -v -H 'Content-Type: application/json' "http adress" -d 'json object' 
example :
curl -v -H 'Content-Type: application/json' "http://localhost:8085/wot/certify" -d '{"uid": "yourUID","from_pubkey": "yourFromPubkey","pubkey":"yourPubkey" }'
curl -v -H 'Content-Type: application/json' "http://localhost:8085/wot/add" -d '{"uid": "yourUID","member": false,"pubkey":"yourPubkey" }'