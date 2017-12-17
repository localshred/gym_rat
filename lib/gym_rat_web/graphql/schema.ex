defmodule GymRatWeb.GraphQL.Schema do
  use Absinthe.Schema

  import_types GymRatWeb.GraphQL.Types

  import_types GymRatWeb.GraphQL.Areas.Types
  import_types GymRatWeb.GraphQL.Areas.Queries
  import_types GymRatWeb.GraphQL.Areas.Mutations

  import_types GymRatWeb.GraphQL.Gyms.Types
  import_types GymRatWeb.GraphQL.Gyms.Queries
  import_types GymRatWeb.GraphQL.Gyms.Mutations

  import_types GymRatWeb.GraphQL.HoldPlacements.Types
  import_types GymRatWeb.GraphQL.HoldPlacements.Queries
  import_types GymRatWeb.GraphQL.HoldPlacements.Mutations

  import_types GymRatWeb.GraphQL.Holds.Types
  import_types GymRatWeb.GraphQL.Holds.Queries
  import_types GymRatWeb.GraphQL.Holds.Mutations

  import_types GymRatWeb.GraphQL.Routes.Types
  import_types GymRatWeb.GraphQL.Routes.Queries
  import_types GymRatWeb.GraphQL.Routes.Mutations

  import_types GymRatWeb.GraphQL.Ticks.Types
  import_types GymRatWeb.GraphQL.Ticks.Queries
  import_types GymRatWeb.GraphQL.Ticks.Mutations

  import_types GymRatWeb.GraphQL.Users.Types
  import_types GymRatWeb.GraphQL.Users.Queries
  import_types GymRatWeb.GraphQL.Users.Mutations

  query do
    import_fields :areas_queries
    import_fields :gyms_queries
    import_fields :hold_placements_queries
    import_fields :holds_queries
    import_fields :routes_queries
    import_fields :ticks_queries
    import_fields :users_queries
  end

  mutation do
    import_fields :areas_mutations
    import_fields :gyms_mutations
    import_fields :hold_placements_mutations
    import_fields :holds_mutations
    import_fields :routes_mutations
    import_fields :ticks_mutations
    import_fields :users_mutations
  end
end
