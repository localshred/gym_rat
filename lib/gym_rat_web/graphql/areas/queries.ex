defmodule GymRatWeb.GraphQL.Areas.Queries do
  use Absinthe.Schema.Notation

  object :area_response do
    field :area, non_null(:area)
  end

  object :areas_response do
    field :area, :area |> non_null |> list_of |> non_null
  end

  object :areas_queries do
    field :areas, non_null(:areas_response) do
      arg :query, non_null(:get_records_input)
      # TODO resolve
    end

    field :area, non_null(:area_response) do
      arg :query, non_null(:get_record_input)
      # TODO resolve
    end
  end
end
