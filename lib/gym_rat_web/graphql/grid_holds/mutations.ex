defmodule GymRatWeb.Graphql.GridHolds.Mutations do
  use Absinthe.Schema.Notation

  alias GymRat.Graphql
  alias GymRat.Inventory
  alias GymRat.Lore
  alias GymRat.WallManagement

  input_object :grid_coordinate_input do
    field(:x, non_null(:float))
    field(:y, non_null(:float))
  end

  input_object :create_grid_hold_input do
    field(:area_id, non_null(:id))
    field(:hold, non_null(:create_hold_input))
    field(:grid_coordinate, non_null(:grid_coordinate_input))
  end

  object :create_grid_hold_response do
    field(:grid_hold, non_null(:grid_hold))
  end

  input_object :update_grid_hold_input do
    field(:area_id, :id)
    field(:hold_id, :id)
    field(:grid_coordinate, :grid_coordinate_input)
  end

  object :update_grid_hold_response do
    field(:grid_hold, non_null(:grid_hold))
  end

  object :grid_holds_mutations do
    field :create_grid_hold, non_null(:create_grid_hold_response) do
      arg(:grid_hold, non_null(:create_grid_hold_input))
      resolve(&create_grid_hold/2)
    end

    field :delete_grid_hold, non_null(:delete_record_response) do
      arg(:query, non_null(:get_record_input))
      resolve(&delete_grid_hold/2)
    end

    field :update_grid_hold, non_null(:update_grid_hold_response) do
      arg(:query, non_null(:get_record_input))
      arg(:grid_hold, non_null(:update_grid_hold_input))
      resolve(&update_grid_hold/2)
    end
  end

  def create_grid_hold(args, _context) do
    args
    |> Lore.prop(:grid_hold)
    |> convert_coordinates()
    |> find_or_create_associated_hold!()
    |> WallManagement.create_grid_hold()
    |> Graphql.db_result_to_response(:grid_hold)
  end

  def delete_grid_hold(args, _context) do
    args
    |> Lore.path([:query, :id])
    |> WallManagement.get_grid_hold()
    |> Graphql.delete_record(&WallManagement.delete_grid_hold/1)
  end

  def update_grid_hold(args, _context) do
    try do
      update_args = args
                    |> Lore.prop(:grid_hold)
                    |> convert_coordinates()

      args
      |> Lore.path([:query, :id])
      |> WallManagement.get_grid_hold!()
      |> WallManagement.update_grid_hold(update_args)
      |> Graphql.db_result_to_response(:grid_hold)
    rescue
      _exception ->
        Lore.error("Unable to update grid hold")
    end
  end

  def convert_coordinates(%{grid_coordinate: %{x: x, y: y}} = grid_hold) do
    grid_hold
    |> Map.delete(:grid_coordinate)
    |> Map.put(:grid_coordinate_x, x)
    |> Map.put(:grid_coordinate_y, y)
  end

  def find_or_create_associated_hold!(%{ hold: hold } = grid_hold) do
    hold = Inventory.find_or_create_hold!(hold)
    grid_hold
    |> Map.delete(:hold)
    |> Map.put(:hold_id, hold.id)
  end
end
