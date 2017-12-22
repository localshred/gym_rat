defmodule GymRatWeb.Graphql.HoldPlacements.Queries do
  use Absinthe.Schema.Notation

  alias GymRat.Lore
  alias GymRat.RouteManagement

  object :hold_placement_response do
    field(:hold_placement, non_null(:hold_placement))
  end

  object :hold_placements_response do
    field(:hold_placements, :hold_placement |> non_null |> list_of |> non_null)
  end

  object :hold_placements_queries do
    field :hold_placement, non_null(:hold_placement_response) do
      arg(:query, non_null(:get_record_input))
      resolve(&get_hold_placement/2)
    end

    field :hold_placements, non_null(:hold_placements_response) do
      arg(:query, non_null(:get_records_input))
      resolve(&list_hold_placements/2)
    end
  end

  def get_hold_placement(args, _context) do
    args
    |> Lore.path([:query, :id])
    |> RouteManagement.get_hold_placement()
    |> Lore.assoc_prop(:hold_placement)
    |> Lore.ok()
  end

  def list_hold_placements(args, _context) do
    args
    |> Lore.path([:query, :ids])
    |> Lore.default_to([])
    |> RouteManagement.list_hold_placements()
    |> Lore.default_to([])
    |> Lore.assoc_prop(:hold_placements)
    |> Lore.ok()
  end
end
