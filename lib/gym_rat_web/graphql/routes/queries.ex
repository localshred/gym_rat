defmodule GymRatWeb.Graphql.Routes.Queries do
  use Absinthe.Schema.Notation

  object :route_response do
    field :route, non_null(:route)
  end

  object :routes_response do
    field :route, :route |> non_null |> list_of |> non_null
  end

  object :routes_queries do
    field :routes, non_null(:routes_response) do
      arg :query, non_null(:get_records_input)
      # TODO resolve
    end

    field :route, non_null(:route_response) do
      arg :query, non_null(:get_record_input)
      # TODO resolve
    end
  end
end
