defmodule GymRatWeb.Graphql.Routes.Mutations do
  use Absinthe.Schema.Notation

  alias GymRat.Graphql
  alias GymRat.Lore
  alias GymRat.RouteManagement

  input_object :create_route_input do
    field :area_id, non_null(:id)
    field :setter_id, non_null(:id)
    field :name, :string
    field :color, non_null(:string)
    field :grade, non_null(:grade_input)
    field :set_on, non_null(:utc_timestamp)
    field :expires_on, :utc_timestamp
  end

  object :create_route_response do
    field :route, non_null(:route)
  end

  input_object :update_route_input do
    field :area_id, :id
    field :setter_id, :id
    field :name, :string
    field :color, :string
    field :grade, :grade_input
    field :set_on, :utc_timestamp
    field :expires_on, :utc_timestamp
  end

  object :update_route_response do
    field :route, non_null(:route)
  end

  object :routes_mutations do
    field :create_route, non_null(:create_route_response) do
      arg :route, non_null(:create_route_input)
      resolve &create_route/2
    end

    field :delete_route, non_null(:delete_record_response) do
      arg :query, non_null(:get_record_input)
      resolve &delete_route/2
    end

    field :update_route, non_null(:update_route_response) do
      arg :query, non_null(:get_record_input)
      arg :route, non_null(:update_route_input)
      resolve &update_route/2
    end
  end

  def create_route(args, _context) do
    args
    |> Lore.prop(:route)
    |> RouteManagement.create_route()
    |> Graphql.db_result_to_response(:route)
  end

  def delete_route(args, _context) do
    args
    |> Lore.path([:query, :id])
    |> RouteManagement.get_route()
    |> Graphql.delete_record(&RouteManagement.delete_route/1)
  end

  def update_route(args, _context)  do
    try do
      args
      |> Lore.path([:query, :id])
      |> RouteManagement.get_route!()
      |> RouteManagement.update_route(args.update)
      |> Graphql.db_result_to_response(:route)
    rescue _exception ->
      Lore.error("Unable to update route")
    end
  end
end

