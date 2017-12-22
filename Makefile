.PHONY: console db.console deps format server

console:
	iex -S mix

db.console:
	psql -U postgres -d gym_rat_dev;

deps:
	mix deps.get

format:
	mix16 format

server:
	iex -S mix phx.server
