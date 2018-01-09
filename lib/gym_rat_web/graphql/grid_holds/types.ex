defmodule GymRatWeb.Graphql.GridHolds.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GymRat.Repo

  alias GymRat.Graphql

  object :grid_coordinate do
    field(:x, non_null(:float), resolve: Graphql.prop_resolver(:grid_coordinate_x))
    field(:y, non_null(:float), resolve: Graphql.prop_resolver(:grid_coordinate_y))
  end

  object :grid_hold do
    field(:id, non_null(:id))
    field(:area, non_null(:area), resolve: assoc(:area))
    field(:grid_coordinate, :grid_coordinate, resolve: &Graphql.identity_resolver/3)
    field(:hold, non_null(:hold), resolve: assoc(:hold))
    field(:inserted_at, non_null(:utc_timestamp))
    field(:updated_at, non_null(:utc_timestamp))
  end
end
