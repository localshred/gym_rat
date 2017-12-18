defmodule GymRatWeb.GraphQL.Types do
  use Absinthe.Schema.Notation

  scalar :utc_timestamp do
    description "Time (in ISOz format)"
    parse fn x -> x end
    serialize fn x -> x end
  end

  input_object :get_record_input do
    field :id, non_null(:id)
  end

  input_object :get_records_input do
    field :id, :id |> non_null |> list_of |> non_null
  end

  object :delete_record_response do
    field :success, non_null(:boolean)
    field :deleted_count, non_null(:integer)
  end
end
