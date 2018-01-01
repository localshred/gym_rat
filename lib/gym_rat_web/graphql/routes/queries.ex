defmodule GymRatWeb.Graphql.Routes.Queries do
  use Absinthe.Schema.Notation

  alias GymRat.Lore
  alias GymRat.RouteManagement

  object :route_response do
    field(:route, :route)
  end

  object :routes_response do
    field(:routes, :route |> non_null |> list_of |> non_null)
  end

  object :routes_queries do
    field :route, non_null(:route_response) do
      arg(:query, non_null(:get_record_input))
      resolve(&get_route/2)
    end

    field :routes, non_null(:routes_response) do
      arg(:query, non_null(:get_records_input))
      resolve(&list_routes/2)
    end
  end

  def get_route(args, _context) do
    args
    |> Lore.path([:query, :id])
    |> RouteManagement.get_route()
    |> Lore.assoc_prop(:route)
    |> Lore.ok()
  end

  def list_routes(args, _context) do
    args
    |> Lore.path([:query, :ids])
    |> Lore.default_to([])
    |> RouteManagement.list_routes()
    |> Lore.default_to([])
    |> Lore.assoc_prop(:routes)
    |> Lore.ok()
  end
end
