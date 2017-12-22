defmodule GymRatWeb.Graphql.Areas.Queries do
  use Absinthe.Schema.Notation

  alias GymRat.Facilities
  alias GymRat.Lore

  object :area_response do
    field(:area, non_null(:area))
  end

  object :areas_response do
    field(:areas, :area |> non_null |> list_of |> non_null)
  end

  object :areas_queries do
    field :area, non_null(:area_response) do
      arg(:query, non_null(:get_record_input))
      resolve(&get_area/2)
    end

    field :areas, non_null(:areas_response) do
      arg(:query, non_null(:get_records_input))
      resolve(&list_areas/2)
    end
  end

  def get_area(args, _context) do
    args
    |> Lore.path([:query, :id])
    |> Facilities.get_area()
    |> Lore.assoc_prop(:area)
    |> Lore.ok()
  end

  def list_areas(args, _context) do
    args
    |> Lore.path([:query, :ids])
    |> Lore.default_to([])
    |> Facilities.list_areas()
    |> Lore.default_to([])
    |> Lore.assoc_prop(:areas)
    |> Lore.ok()
  end
end
