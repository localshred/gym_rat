defmodule GymRatWeb.Router do
  use GymRatWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", GymRatWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  forward "/graphql", Absinthe.Plug, schema: GymRatWeb.Graphql.Schema
  forward "/graphiql", Absinthe.Plug.GraphiQL, schema: GymRatWeb.Graphql.Schema
end
