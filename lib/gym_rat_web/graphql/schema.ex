defmodule GymRatWeb.Graphql.Schema do
  use Absinthe.Schema

  # Additional types and scalars
  import_types(GymRatWeb.Graphql.Scalars.UtcTimestamp)
  import_types(GymRatWeb.Graphql.Types)

  # All top-level types
  import_types(GymRatWeb.Graphql.Areas.Types)
  import_types(GymRatWeb.Graphql.Grades.Types)
  import_types(GymRatWeb.Graphql.Gyms.Types)
  import_types(GymRatWeb.Graphql.Holds.Types)
  import_types(GymRatWeb.Graphql.Routes.Types)
  import_types(GymRatWeb.Graphql.HoldPlacements.Types)
  import_types(GymRatWeb.Graphql.Ticks.Types)
  import_types(GymRatWeb.Graphql.Users.Types)

  # All Queries definitions
  import_types(GymRatWeb.Graphql.Areas.Queries)
  import_types(GymRatWeb.Graphql.Grades.Queries)
  import_types(GymRatWeb.Graphql.Gyms.Queries)
  import_types(GymRatWeb.Graphql.HoldPlacements.Queries)
  import_types(GymRatWeb.Graphql.Holds.Queries)
  import_types(GymRatWeb.Graphql.Routes.Queries)
  import_types(GymRatWeb.Graphql.Ticks.Queries)
  import_types(GymRatWeb.Graphql.Users.Queries)

  # All Mutations definitions
  import_types(GymRatWeb.Graphql.Areas.Mutations)
  import_types(GymRatWeb.Graphql.Grades.Mutations)
  import_types(GymRatWeb.Graphql.Gyms.Mutations)
  import_types(GymRatWeb.Graphql.HoldPlacements.Mutations)
  import_types(GymRatWeb.Graphql.Holds.Mutations)
  import_types(GymRatWeb.Graphql.Routes.Mutations)
  import_types(GymRatWeb.Graphql.Ticks.Mutations)
  import_types(GymRatWeb.Graphql.Users.Mutations)

  query do
    import_fields(:areas_queries)
    import_fields(:grades_queries)
    import_fields(:gyms_queries)
    import_fields(:hold_placements_queries)
    import_fields(:holds_queries)
    import_fields(:routes_queries)
    import_fields(:ticks_queries)
    import_fields(:users_queries)
  end

  mutation do
    import_fields(:areas_mutations)
    import_fields(:grades_mutations)
    import_fields(:gyms_mutations)
    import_fields(:hold_placements_mutations)
    import_fields(:holds_mutations)
    import_fields(:routes_mutations)
    import_fields(:ticks_mutations)
    import_fields(:users_mutations)
  end
end
