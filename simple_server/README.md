# SimpleServer

Simple server simulating answers to some Duniter HTTP requests, testing database manipulations and a beginning of processing distribution.

## Installation

make install<br />
make run<br />

The make install command will try to install postgres and change user "postgres" password to "postgres".
Then it will get dependencies and create the databases.<br />

If you have already completed any of these step, refer to the Makefile. make drop & make create to refresh de db, make run to start the server.<br />

## Send requests

curl -v "http://localhost:8085/node/summary"<br />
curl -v "http://localhost:8085/node/sandboxes"<br />
curl -v -H 'Content-Type: application/json' "http://localhost:8085/wot/certify" -d '{"uid": "yourUID","from_pubkey": "yourFromPubkey","pubkey":"yourPubkey" }'<br />
curl -v -H 'Content-Type: application/json' "http://localhost:8085/wot/add" -d '{"uid": "yourUID","member": false,"pubkey":"yourPubkey" }'<br />
