defmodule GymRatWeb.Graphql.Gyms.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GymRat.Repo

  object :gym do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :website, non_null(:string)
    field :address, :string
    field :areas, :area |> non_null |> list_of, resolve: assoc(:areas)
    field :inserted_at, non_null(:utc_timestamp)
    field :updated_at, non_null(:utc_timestamp)
  end
end
