defmodule GymRatWeb.GraphQL.Ticks.Queries do
  use Absinthe.Schema.Notation

  object :tick_response do
    field :tick, non_null(:tick)
  end

  object :ticks_response do
    field :tick, :tick |> non_null |> list_of |> non_null
  end

  object :ticks_queries do
    field :ticks, non_null(:ticks_response) do
      arg :query, non_null(:get_records_input)
      # TODO resolve
    end

    field :tick, non_null(:tick_response) do
      arg :query, non_null(:get_record_input)
      # TODO resolve
    end
  end
end
