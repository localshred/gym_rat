defmodule GymRatWeb.Graphql.Users.Queries do
  use Absinthe.Schema.Notation

  alias GymRat.Accounts
  alias GymRat.Lore

  object :user_response do
    field(:user, :user)
  end

  object :users_response do
    field(:users, :user |> non_null |> list_of |> non_null)
  end

  object :users_queries do
    field :user, non_null(:user_response) do
      arg(:query, non_null(:get_record_input))
      resolve(&get_user/2)
    end

    field :users, non_null(:users_response) do
      arg(:query, non_null(:get_records_input))
      resolve(&list_users/2)
    end
  end

  def get_user(args, _context) do
    args
    |> Lore.path([:query, :id])
    |> Accounts.get_user()
    |> Lore.assoc_prop(:user)
    |> Lore.ok()
  end

  def list_users(args, _context) do
    args
    |> Lore.path([:query, :ids])
    |> Lore.default_to([])
    |> Accounts.list_users()
    |> Lore.default_to([])
    |> Lore.assoc_prop(:users)
    |> Lore.ok()
  end
end
