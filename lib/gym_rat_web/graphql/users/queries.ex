defmodule GymRatWeb.GraphQL.Users.Queries do
  use Absinthe.Schema.Notation

  import_types GymRatWeb.GraphQL.Users.Types

  object :user_response do
    field :user, non_null(:user)
  end

  object :users_response do
    field :user, :user |> non_null |> list_of |> non_null
  end

  object :users_queries do
    field :users, non_null(:users_response)
    field :user, non_null(:user_response)
  end
end
