defmodule GymRatWeb.Graphql.Holds.Queries do
  use Absinthe.Schema.Notation

  alias GymRat.Inventory
  alias GymRat.Lore

  object :hold_response do
    field(:hold, non_null(:hold))
  end

  object :holds_response do
    field(:holds, :hold |> non_null |> list_of |> non_null)
  end

  object :holds_queries do
    field :hold, non_null(:hold_response) do
      arg(:query, non_null(:get_record_input))
      resolve(&get_hold/2)
    end

    field :holds, non_null(:holds_response) do
      arg(:query, non_null(:get_records_input))
      resolve(&list_holds/2)
    end
  end

  def get_hold(args, _context) do
    args
    |> Lore.path([:query, :id])
    |> Inventory.get_hold()
    |> Lore.assoc_prop(:hold)
    |> Lore.ok()
  end

  def list_holds(args, _context) do
    args
    |> Lore.path([:query, :ids])
    |> Lore.default_to([])
    |> Inventory.list_holds()
    |> Lore.default_to([])
    |> Lore.assoc_prop(:holds)
    |> Lore.ok()
  end
end
