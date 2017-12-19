defmodule GymRatWeb.Graphql.Gyms.Queries do
  use Absinthe.Schema.Notation

  alias GymRat.Lore
  alias GymRat.Physical

  object :gym_response do
    field :gym, :gym
  end

  object :gyms_response do
    field :gyms, :gym |> non_null |> list_of |> non_null
  end

  object :gyms_queries do

    field :gym, non_null(:gym_response) do
      arg :query, non_null(:get_record_input)

      resolve fn
        (args, _context) ->
          args
          |> Lore.inspect(:args)
          |> Lore.path([:query, :id])
          |> Lore.inspect(:id)
          |> Physical.get_gym()
          |> Lore.assoc_prop(:gym)
          |> Lore.ok()
      end
    end

    field :gyms, non_null(:gyms_response) do
      arg :query, non_null(:get_records_input)

      resolve fn (args, _context) ->
        args
        |> Lore.path([:query, :ids])
        |> Lore.default_to([])
        |> Physical.list_gyms()
        |> Lore.default_to([])
        |> Lore.assoc_prop(:gyms)
        |> Lore.ok()
      end
    end

  end

end
