defmodule GymRatWeb.GraphQL.HoldPlacements.Queries do
  use Absinthe.Schema.Notation

  object :hold_placement_response do
    field :hold_placement, non_null(:hold_placement)
  end

  object :hold_placements_response do
    field :hold_placement, :hold_placement |> non_null |> list_of |> non_null
  end

  object :hold_placements_queries do
    field :hold_placements, non_null(:hold_placements_response) do
      arg :query, non_null(:get_records_input)
      # TODO resolve
    end

    field :hold_placement, non_null(:hold_placement_response) do
      arg :query, non_null(:get_record_input)
      # TODO resolve
    end
  end
end
