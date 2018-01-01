defmodule GymRatWeb.Graphql.Ticks.Queries do
  use Absinthe.Schema.Notation

  alias GymRat.Climbing
  alias GymRat.Lore

  object :tick_response do
    field(:tick, :tick)
  end

  object :ticks_response do
    field(:ticks, :tick |> non_null |> list_of |> non_null)
  end

  object :ticks_queries do
    field :tick, non_null(:tick_response) do
      arg(:query, non_null(:get_record_input))
      resolve(&get_tick/2)
    end

    field :ticks, non_null(:ticks_response) do
      arg(:query, non_null(:get_records_input))
      resolve(&list_ticks/2)
    end
  end

  def get_tick(args, _context) do
    args
    |> Lore.path([:query, :id])
    |> Climbing.get_tick()
    |> Lore.assoc_prop(:tick)
    |> Lore.ok()
  end

  def list_ticks(args, _context) do
    args
    |> Lore.path([:query, :ids])
    |> Lore.default_to([])
    |> Climbing.list_ticks()
    |> Lore.default_to([])
    |> Lore.assoc_prop(:ticks)
    |> Lore.ok()
  end
end
