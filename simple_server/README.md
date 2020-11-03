# SimpleServer

Simple server simulating answers to some Duniter HTTP requests, testing database manipulations and a beginning of processing distribution.

## Installation

make install
make run

The make install command will try to install postgres and change user "postgres" password to "postgres".
Then it will get dependencies and create the databases.

If you have already completed any of these step, refer to the Makefile. make drop & make create to refresh de db, make run to start the server.
