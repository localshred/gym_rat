defmodule GymRatWeb.Graphql.HoldPlacements.Types do
  use Absinthe.Schema.Notation

  object :hold_placement do
    field :id, non_null(:id)
    field :route, non_null(:route)
    field :hold, non_null(:hold)
    field :grid_coordinate, :grid_coordinate
    field :is_start, non_null(:boolean)
    field :is_finish, non_null(:boolean)
    field :created_at, non_null(:utc_timestamp)
    field :updated_at, non_null(:utc_timestamp)
  end

  object :grid_coordinate do
    field :x, non_null(:string)
    field :y, non_null(:string)
  end
end
