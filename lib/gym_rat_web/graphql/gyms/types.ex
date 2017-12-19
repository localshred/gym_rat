defmodule GymRatWeb.Graphql.Gyms.Types do
  use Absinthe.Schema.Notation

  object :gym do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :website, non_null(:string)
    field :address, :string
    field :inserted_at, non_null(:utc_timestamp)
    field :updated_at, non_null(:utc_timestamp)
  end
end
