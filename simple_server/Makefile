deps:
	mix deps.get

create:
	mix ecto.create
	mix ecto.migrate
drop:
	mix ecto.drop

postgres:
	sudo bash -x postgres.sh postgres

install:
	make postgres
	make deps
	make create
run: deps
	iex -S mix
