defmodule GymRatWeb.GraphQL.Users.Queries do
  use Absinthe.Schema.Notation

  object :user_response do
    field :user, non_null(:user)
  end

  object :users_response do
    field :user, :user |> non_null |> list_of |> non_null
  end

  object :users_queries do
    field :users, non_null(:users_response) do
      arg :query, non_null(:get_records_input)
      # TODO resolve
    end

    field :user, non_null(:user_response) do
      arg :query, non_null(:get_record_input)
      # TODO resolve
    end
  end
end
