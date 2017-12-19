console:
	iex -S mix

deps:
	mix deps.get

server:
	iex -S mix phx.server

.PHONY: console deps server
