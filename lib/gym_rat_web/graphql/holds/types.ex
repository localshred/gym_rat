defmodule GymRatWeb.Graphql.Holds.Types do
  use Absinthe.Schema.Notation

  enum :material do
    value :plastic, description: "Plastic injection-molded holds"
    value :wood, description: "Wood-shaped holds"
    value :rock, description: "Real rock holds"
  end

  enum :hold_type do
    value :handhold, description: "Hold primarily intended for use with hands"
    value :foothold, description: "Hold primarily intended for use with feet"
    value :volume, description: "Hold primarily intended for extending or changing the dynamic of the wall surface"
  end

  object :hold do
    field :id, non_null(:id)
    field :maker, non_null(:string)
    field :color, non_null(:string)
    field :size, non_null(:string)
    field :count, :integer
    field :material, :material
    field :features, :string
    field :primary_use, :hold_type
    field :inserted_at, non_null(:utc_timestamp)
    field :updated_at, non_null(:utc_timestamp)
  end
end
