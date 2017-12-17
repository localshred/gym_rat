defmodule GymRatWeb.GraphQL.Schema do
  use Absinthe.Schema

  import_types GymRatWeb.GraphQL.Users.Queries

  query do
    import_fields :users_queries
  end

  mutation do
  end
end
