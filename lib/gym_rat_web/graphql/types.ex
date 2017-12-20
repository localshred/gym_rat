defmodule GymRatWeb.Graphql.Types do
  use Absinthe.Schema.Notation

  input_object :get_record_input do
    field :id, non_null(:id)
  end

  input_object :get_records_input do
    field :ids, :id |> non_null |> list_of
  end

  object :delete_record_response do
    field :success, non_null(:boolean)
    field :deleted_count, non_null(:integer)
  end
end
