deps:
	mix deps.get

server:
	iex -S mix phx.server

.PHONY: deps server
