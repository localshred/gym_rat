defmodule GymRatWeb.GraphQL.Holds.Types do
  use Absinthe.Schema.Notation

  enum :material do
    value :plastic
    value :wood
    value :rock
  end

  enum :hold_type do
    value :handhold
    value :foothold
    value :volume
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
    field :created_at, non_null(:utc_timestamp)
    field :updated_at, non_null(:utc_timestamp)
  end
end
