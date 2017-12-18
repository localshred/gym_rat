defmodule GymRatWeb.Graphql.Holds.Queries do
  use Absinthe.Schema.Notation

  object :hold_response do
    field :hold, non_null(:hold)
  end

  object :holds_response do
    field :hold, :hold |> non_null |> list_of |> non_null
  end

  object :holds_queries do
    field :holds, non_null(:holds_response) do
      arg :query, non_null(:get_records_input)
      # TODO resolve
    end

    field :hold, non_null(:hold_response) do
      arg :query, non_null(:get_record_input)
      # TODO resolve
    end
  end
end
