defmodule GymRatWeb.Graphql.HoldPlacements.Mutations do
  use Absinthe.Schema.Notation

  alias GymRat.Graphql
  alias GymRat.Lore
  alias GymRat.RouteManagement

  input_object :grid_coordinate_input do
    field :x, non_null(:integer)
    field :y, non_null(:integer)
  end

  input_object :create_hold_placement_input do
    field :route_id, non_null(:id)
    field :hold_id, non_null(:id)
    field :grid_coordinate, non_null(:grid_coordinate_input)
    field :is_start, :boolean
    field :is_finish, :boolean
  end

  object :create_hold_placement_response do
    field :hold_placement, non_null(:hold_placement)
  end

  input_object :update_hold_placement_input do
    field :hold_id, :id
    field :grid_coordinate, :grid_coordinate_input
    field :is_start, :boolean
    field :is_finish, :boolean
  end

  object :update_hold_placement_response do
    field :hold_placement, non_null(:hold_placement)
  end

  object :hold_placements_mutations do
    field :create_hold_placement, non_null(:create_hold_placement_response) do
      arg :query, non_null(:create_hold_placement_input)
      resolve &create_hold_placement/2
    end

    field :delete_hold_placement, non_null(:delete_record_response) do
      arg :query, non_null(:get_record_input)
      resolve &delete_hold_placement/2
    end

    field :update_hold_placement, non_null(:update_hold_placement_response) do
      arg :query, non_null(:get_record_input)
      arg :update, non_null(:update_hold_placement_input)
      resolve &update_hold_placement/2
    end
  end

  def create_hold_placement(args, _context) do
    args
    |> Lore.prop(:hold_placement)
    |> RouteManagement.create_hold_placement()
    |> Graphql.db_result_to_response(:hold_placement)
  end

  def delete_hold_placement(args, _context) do
    args
    |> Lore.path([:query, :id])
    |> RouteManagement.get_hold_placement()
    |> Graphql.delete_record(&RouteManagement.delete_hold_placement/1)
  end

  def update_hold_placement(args, _context)  do
    try do
      args
      |> Lore.path([:query, :id])
      |> RouteManagement.get_hold_placement!()
      |> RouteManagement.update_hold_placement(args.update)
      |> Graphql.db_result_to_response(:hold_placement)
    rescue exception ->
      Lore.error("Unable to update hold placement")
    end
  end
end
