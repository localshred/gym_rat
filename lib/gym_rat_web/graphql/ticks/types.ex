defmodule GymRatWeb.Graphql.Ticks.Types do
  use Absinthe.Schema.Notation

  enum :tick_rating do
    description "An optional user rating for a tick"
    value :three_stars
    value :two_stars
    value :one_star
    value :zero_stars
  end

  enum :send_type do
    description "The way the user climbed the route"
    value :onsight, description: "Onsight"
    value :flash, description: "Flash"
    value :redpoint, description: "Redpoint"
    value :repeat, description: "Repeat"
  end

  object :tick do
    field :id, non_null(:id)
    field :user, non_null(:user)
    field :route, non_null(:route)
    field :user_grade, :grade
    field :number_tries, :integer
    field :rating, :tick_rating
    field :send_type, non_null(:send_type)
    field :sent_on, non_null(:utc_timestamp)
    field :created_at, non_null(:utc_timestamp)
    field :updated_at, non_null(:utc_timestamp)
  end
end
