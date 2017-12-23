defmodule GymRatWeb.Router do
  use GymRatWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :graphql do
    plug(:accepts, ["json"])
    # plug(GymRatWeb.Plug.ConnectionInterceptor)
  end

  scope "/", GymRatWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  scope("/graphql") do
    pipe_through(:graphql)

    forward("/", Absinthe.Plug, schema: GymRatWeb.Graphql.Schema)
  end

  forward("/graphiql", Absinthe.Plug.GraphiQL, schema: GymRatWeb.Graphql.Schema)
end
