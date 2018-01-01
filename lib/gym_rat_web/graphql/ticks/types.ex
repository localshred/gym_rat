defmodule GymRatWeb.Graphql.Ticks.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GymRat.Repo

  alias GymRat.Graphql

  enum :tick_rating do
    description("An optional user rating for a tick")
    value(:three_stars)
    value(:two_stars)
    value(:one_star)
    value(:zero_stars)
  end

  enum :send_type do
    description("The way the user climbed the route")
    value(:onsight, description: "Onsight")
    value(:flash, description: "Flash")
    value(:redpoint, description: "Redpoint")
    value(:repeat, description: "Repeat")
  end

  object :tick do
    field(:id, non_null(:id))
    field(:user, non_null(:user), resolve: assoc(:user))
    field(:route, non_null(:route), resolve: assoc(:route))
    field(:user_grade, :grade)
    field(:number_tries, :integer)
    field(:rating, :tick_rating, resolve: Graphql.enum_value_resolver(:tick_rating))
    field(:send_type, non_null(:send_type), resolve: Graphql.enum_value_resolver(:send_type))
    field(:ticked_at, non_null(:utc_timestamp))
    field(:inserted_at, non_null(:utc_timestamp))
    field(:updated_at, non_null(:utc_timestamp))
  end
end
