.PHONY: console db.console deps format server test test.watch test.debug

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

test:
	mix test

test.watch:
	mix test --listen-on-stdin

test.debug:
	iex -S mix test --trace --listen-on-stdin
