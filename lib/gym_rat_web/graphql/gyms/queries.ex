defmodule GymRatWeb.Graphql.Gyms.Queries do
  use Absinthe.Schema.Notation

  alias GymRat.Lore
  alias GymRat.Facilities

  object :gym_response do
    field :gym, :gym
  end

  object :gyms_response do
    field :gyms, :gym |> non_null |> list_of |> non_null
  end

  object :gyms_queries do

    field :gym, non_null(:gym_response) do
      arg :query, non_null(:get_record_input)
      resolve &get_gym/2
    end

    field :gyms, non_null(:gyms_response) do
      arg :query, non_null(:get_records_input)
      resolve &list_gyms/2
    end
  end

  def get_gym(args, _context) do
    args
    |> Lore.path([:query, :id])
    |> Facilities.get_gym()
    |> Lore.assoc_prop(:gym)
    |> Lore.ok()
  end

  def list_gyms(args, _context) do
    args
    |> Lore.path([:query, :ids])
    |> Lore.default_to([])
    |> Facilities.list_gyms()
    |> Lore.default_to([])
    |> Lore.assoc_prop(:gyms)
    |> Lore.ok()
  end


end
