defmodule GymRatWeb.Graphql.Users.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GymRat.Repo

  alias GymRat.Graphql

  object :user do
    field(:id, non_null(:id))
    field :avatar, non_null(:avatar), resolve: &Graphql.identity_resolver/3
    field(:email, non_null(:string))
    field(:inserted_at, non_null(:utc_timestamp))
    field(:name, :string)
    field(:ticks, :tick |> non_null |> list_of, resolve: assoc(:ticks))
    field(:updated_at, non_null(:utc_timestamp))
    field(:username, non_null(:string))
  end

  object :avatar do
    field :url, non_null(:string), resolve: &resolve_avatar_url/3 do
      arg(:size, :integer)
    end
  end

  def resolve_avatar_url(user, args, _resolution) do
    user
    |> Map.get(:email)
    |> gravatar_hash()
    |> gravatar_url(args)
    |> (fn url -> {:ok, url} end).()
  end

  def gravatar_hash(email) do
    email
    |> String.trim()
    |> String.downcase()
    |> :erlang.md5()
    |> Base.encode16(case: :lower)
  end

  def gravatar_url(email_hash, args) do
    "https://www.gravatar.com/avatar/#{email_hash}?d=retro&r=pg&s=#{
      gravatar_size(Map.get(args, :size))
    }"
  end

  def gravatar_size(size) when size in 1..2048, do: size
  def gravatar_size(_), do: 35
  def gravatar_size, do: 35
end
