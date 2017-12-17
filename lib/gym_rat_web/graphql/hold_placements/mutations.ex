defmodule GymRatWeb.GraphQL.HoldPlacements.Mutations do
  use Absinthe.Schema.Notation

  input_object :create_hold_placement_input do
    # TODO
  end

  object :create_hold_placement_response do
    field :hold_placement, non_null(:hold_placement)
  end

  input_object :update_hold_placement_input do
    # TODO
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

