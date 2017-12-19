defmodule GymRatWeb.Graphql.Areas.Types do
  use Absinthe.Schema.Notation

  object :area do
    field :id, non_null(:id)
    field :gym, non_null(:gym)
    field :name, non_null(:string)
    field :order, :integer
    field :inserted_at, non_null(:utc_timestamp)
    field :updated_at, non_null(:utc_timestamp)
  end
end
