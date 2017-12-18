defmodule GymRatWeb.GraphQL.Routes.Types do
  use Absinthe.Schema.Notation

  @desc "Breakdown of grades that may be assigned or derived for a route"
  object :route_grades do
    field :initial_grade, non_null(:grade)
    field :consensus_grade, non_null(:grade)
  end

  @desc "A route that has been set for climbers"
  object :route do
    field :id, non_null(:id)
    field :area, non_null(:area)
    field :setter, non_null(:user)
    field :color, non_null(:string)
    field :grades, non_null(:route_grades)
    field :ticks, :tick |> non_null |> list_of |> non_null
    field :set_on, non_null(:utc_timestamp)
    field :expires_on, :utc_timestamp
    field :created_at, non_null(:utc_timestamp)
    field :updated_at, non_null(:utc_timestamp)
  end
end
