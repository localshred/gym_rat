defmodule GymRatWeb.Graphql.HoldPlacements.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GymRat.Repo

  object :grid_coordinate do
    field :x, non_null(:string) do
      resolve(fn hold_placement, _args, _context ->
        hold_placement.grid_coordinate_x
      end)
    end

    field :y, non_null(:string) do
      resolve(fn hold_placement, _args, _context ->
        hold_placement.grid_coordinate_x
      end)
    end
  end

  object :hold_placement do
    field(:id, non_null(:id))
    field(:route, non_null(:route), resolve: assoc(:route))
    field(:hold, non_null(:hold), resolve: assoc(:hold))

    field :grid_coordinate, :grid_coordinate do
      resolve(fn hold_placement, _args, _context ->
        hold_placement
      end)
    end

    field(:is_start, non_null(:boolean))
    field(:is_finish, non_null(:boolean))
    field(:inserted_at, non_null(:utc_timestamp))
    field(:updated_at, non_null(:utc_timestamp))
  end
end
