defmodule GymRatWeb.GraphQL.Gyms.Queries do
  use Absinthe.Schema.Notation

  object :gym_response do
    field :gym, non_null(:gym)
  end

  object :gyms_response do
    field :gym, :gym |> non_null |> list_of |> non_null
  end

  object :gyms_queries do
    field :gyms, non_null(:gyms_response) do
      arg :query, non_null(:get_records_input)
      # TODO resolve
    end

    field :gym, non_null(:gym_response) do
      arg :query, non_null(:get_record_input)
      # TODO resolve
    end
  end
end
