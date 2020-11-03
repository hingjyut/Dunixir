# SimpleServer

Simple server simulating answers to some Duniter HTTP requests, testing database manipulations and a beginning of processing distribution.

## Installation

make install
make run

The make install command will try to install postgres and change user "postgres" password to "postgres".
Then it will get dependencies and create the databases.

If you have already completed any of these step, refer to the Makefile. make drop & make create to refresh de db, make run to start the server.

## Send requests

curl -v "http://localhost:8085/node/summary"
curl -v "http://localhost:8085/node/sandboxes"
curl -v -H 'Content-Type: application/json' "http://localhost:8085/wot/certify" -d '{"uid": "yourUID","from_pubkey": "yourFromPubkey","pubkey":"yourPubkey" }'
curl -v -H 'Content-Type: application/json' "http://localhost:8085/wot/add" -d '{"uid": "yourUID","member": false,"pubkey":"yourPubkey" }'
