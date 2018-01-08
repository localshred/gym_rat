defmodule GymRatWeb.Graphql.HoldPlacements.Mutations do
  use Absinthe.Schema.Notation

  alias GymRat.Graphql
  alias GymRat.Inventory
  alias GymRat.Lore
  alias GymRat.RouteManagement

  input_object :grid_coordinate_input do
    field(:x, non_null(:float))
    field(:y, non_null(:float))
  end

  input_object :create_hold_placement_input do
    field(:area_id, non_null(:id))
    field(:hold, non_null(:create_hold_input))
    field(:grid_coordinate, non_null(:grid_coordinate_input))
  end

  object :create_hold_placement_response do
    field(:hold_placement, non_null(:hold_placement))
  end

  input_object :update_hold_placement_input do
    field(:area_id, :id)
    field(:hold_id, :id)
    field(:grid_coordinate, :grid_coordinate_input)
  end

  object :update_hold_placement_response do
    field(:hold_placement, non_null(:hold_placement))
  end

  object :hold_placements_mutations do
    field :create_hold_placement, non_null(:create_hold_placement_response) do
      arg(:hold_placement, non_null(:create_hold_placement_input))
      resolve(&create_hold_placement/2)
    end

    field :delete_hold_placement, non_null(:delete_record_response) do
      arg(:query, non_null(:get_record_input))
      resolve(&delete_hold_placement/2)
    end

    field :update_hold_placement, non_null(:update_hold_placement_response) do
      arg(:query, non_null(:get_record_input))
      arg(:hold_placement, non_null(:update_hold_placement_input))
      resolve(&update_hold_placement/2)
    end
  end

  def create_hold_placement(args, _context) do
    args
    |> Lore.prop(:hold_placement)
    |> convert_coordinates()
    |> find_or_create_associated_hold!()
    |> RouteManagement.create_hold_placement()
    |> Graphql.db_result_to_response(:hold_placement)
  end

  def delete_hold_placement(args, _context) do
    args
    |> Lore.path([:query, :id])
    |> RouteManagement.get_hold_placement()
    |> Graphql.delete_record(&RouteManagement.delete_hold_placement/1)
  end

  def update_hold_placement(args, _context) do
    try do
      update_args = args
                    |> Lore.prop(:hold_placement)
                    |> convert_coordinates()

      args
      |> Lore.path([:query, :id])
      |> RouteManagement.get_hold_placement!()
      |> RouteManagement.update_hold_placement(update_args)
      |> Graphql.db_result_to_response(:hold_placement)
    rescue
      _exception ->
        Lore.error("Unable to update hold placement")
    end
  end

  def convert_coordinates(%{grid_coordinate: %{x: x, y: y}} = hold_placement) do
    hold_placement
    |> Map.delete(:grid_coordinate)
    |> Map.put(:grid_coordinate_x, x)
    |> Map.put(:grid_coordinate_y, y)
  end

  def find_or_create_associated_hold!(%{ hold: hold } = hold_placement) do
    hold = Inventory.find_or_create_hold!(hold)
    hold_placement
    |> Map.delete(:hold)
    |> Map.put(:hold_id, hold.id)
  end
end
