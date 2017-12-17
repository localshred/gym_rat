defmodule GymRatWeb.GraphQL.Schema do
  use Absinthe.Schema

  import_types GymRatWeb.GraphQL.Types

  import_types GymRatWeb.GraphQL.Users.Types
  import_types GymRatWeb.GraphQL.Users.Queries
  import_types GymRatWeb.GraphQL.Users.Mutations

  query do
    import_fields :users_queries
  end

  mutation do
    import_fields :users_mutations
  end
end
