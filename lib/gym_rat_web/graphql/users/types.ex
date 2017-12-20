defmodule GymRatWeb.Graphql.Users.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GymRat.Repo

  object :user do
    field :id, non_null(:id)
    field :name, :string
    field :username, non_null(:string)
    field :email, non_null(:string)
    field :avatar, non_null(:avatar) do
      resolve fn parent, _args, _info -> { :ok, parent } end
    end
    field :ticks, :tick |> non_null |> list_of, resolve: assoc(:ticks)
  end

  object :avatar do
    field :url, non_null(:string) do
      arg :size, :integer
      resolve &resolve_avatar_url/3
    end
  end

  def resolve_avatar_url(user, args, _resolution) do
    user
    |> Map.get(:email)
    |> gravatar_hash()
    |> gravatar_url(args)
    |> (fn url -> { :ok, url } end).()
  end

  def gravatar_hash(email) do
    email
    |> String.trim()
    |> String.downcase()
    |> :erlang.md5()
    |> Base.encode16(case: :lower)
  end

  def gravatar_url(email_hash, args) do
    "https://www.gravatar.com/avatar/#{email_hash}?d=retro&r=pg&s=#{gravatar_size(Map.get(args, :size))}"
  end

  def gravatar_size(size) when size in 1..2048, do: size
  def gravatar_size(_), do: 35
  def gravatar_size, do: 35
end
