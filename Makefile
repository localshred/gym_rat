console:
	iex -S mix

deps:
	mix deps.get

server:
	iex -S mix phx.server

.PHONY: console deps server

format:
	/code/src/languages/elixir/bin/mix format {lib,test,priv,config}/**/*.{ex,exs}
