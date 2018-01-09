defmodule GymRatWeb.Graphql.GridHolds.Queries do
  use Absinthe.Schema.Notation

  alias GymRat.Lore
  alias GymRat.WallManagement

  object :grid_hold_response do
    field(:grid_hold, :grid_hold)
  end

  object :grid_holds_response do
    field(:grid_holds, :grid_hold |> non_null |> list_of |> non_null)
  end

  object :grid_holds_queries do
    field :grid_hold, non_null(:grid_hold_response) do
      arg(:query, non_null(:get_record_input))
      resolve(&get_grid_hold/2)
    end

    field :grid_holds, non_null(:grid_holds_response) do
      arg(:query, non_null(:get_records_input))
      resolve(&list_grid_holds/2)
    end
  end

  def get_grid_hold(args, _context) do
    args
    |> Lore.path([:query, :id])
    |> WallManagement.get_grid_hold()
    |> Lore.assoc_prop(:grid_hold)
    |> Lore.ok()
  end

  def list_grid_holds(args, _context) do
    args
    |> Lore.path([:query, :ids])
    |> Lore.default_to([])
    |> WallManagement.list_grid_holds()
    |> Lore.default_to([])
    |> Lore.assoc_prop(:grid_holds)
    |> Lore.ok()
  end
end
