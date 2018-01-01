defmodule GymRatWeb.Graphql.Areas.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GymRat.Repo

  object :area do
    field(:id, non_null(:id))
    field(:gym, non_null(:gym), resolve: assoc(:gym))
    field(:routes, :route |> non_null |> list_of |> non_null, resolve: assoc(:routes))
    field(:name, non_null(:string))
    field(:order, :integer)
    field(:inserted_at, non_null(:utc_timestamp))
    field(:updated_at, non_null(:utc_timestamp))
  end
end
