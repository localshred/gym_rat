defmodule GymRatWeb.Graphql.HoldPlacements.Mutations do
  use Absinthe.Schema.Notation

  input_object :grid_coordinate_input do
    field :x, non_null(:integer)
    field :y, non_null(:integer)
  end

  input_object :create_hold_placement_input do
    field :route_id, :integer
    field :hold_id, :integer
    field :grid_coordinate, :grid_coordinate_input
    field :is_start, :boolean
    field :is_finish, :boolean
  end

  object :create_hold_placement_response do
    field :hold_placement, non_null(:hold_placement)
  end

  input_object :update_hold_placement_input do
    field :hold_id, :integer
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
      # TODO resolve
    end

    field :delete_hold_placement, non_null(:delete_record_response) do
      arg :query, non_null(:get_record_input)
      # TODO resolve
    end

    field :update_hold_placement, non_null(:update_hold_placement_response) do
      arg :query, non_null(:get_record_input)
      arg :update, non_null(:update_hold_placement_input)
      # TODO resolve
    end
  end
end

