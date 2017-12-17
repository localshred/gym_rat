defmodule GymRatWeb.GraphQL.Routes.Mutations do
  use Absinthe.Schema.Notation

  input_object :create_route_input do
    # TODO
  end

  object :create_route_response do
    field :route, non_null(:route)
  end

  input_object :update_route_input do
    # TODO
  end

  object :update_route_response do
    field :route, non_null(:route)
  end

  object :routes_mutations do
    field :create_route, non_null(:create_route_response) do
      arg :query, non_null(:create_route_input)
      # TODO resolve
    end

    field :delete_route, non_null(:delete_record_response) do
      arg :query, non_null(:get_record_input)
      # TODO resolve
    end

    field :update_route, non_null(:update_route_response) do
      arg :query, non_null(:get_record_input)
      arg :update, non_null(:update_route_input)
      # TODO resolve
    end
  end
end

