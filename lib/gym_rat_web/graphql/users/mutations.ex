defmodule GymRatWeb.Graphql.Users.Mutations do
  use Absinthe.Schema.Notation

  alias GymRat.Accounts
  alias GymRat.Graphql
  alias GymRat.Lore

  input_object :create_user_input do
    field(:name, :string)
    field(:username, non_null(:string))
    field(:email, non_null(:string))
    field(:password, non_null(:string))
    field(:password_confirmation, non_null(:string))
  end

  object :create_user_response do
    field(:user, non_null(:user))
  end

  input_object :update_user_input do
    field(:name, :string)
    field(:username, :string)
    field(:email, :string)
  end

  object :update_user_response do
    field(:user, non_null(:user))
  end

  object :users_mutations do
    field :create_user, non_null(:create_user_response) do
      arg(:user, non_null(:create_user_input))
      resolve(&create_user/2)
    end

    field :delete_user, non_null(:delete_record_response) do
      arg(:query, non_null(:get_record_input))
      resolve(&delete_user/2)
    end

    field :update_user, non_null(:update_user_response) do
      arg(:query, non_null(:get_record_input))
      arg(:user, non_null(:update_user_input))
      resolve(&update_user/2)
    end
  end

  def create_user(args, _context) do
    args
    |> Lore.prop(:user)
    |> Accounts.create_user()
    |> Graphql.db_result_to_response(:user)
  end

  def delete_user(args, _context) do
    args
    |> Lore.path([:query, :id])
    |> Accounts.get_user()
    |> Graphql.delete_record(&Accounts.delete_user/1)
  end

  def update_user(args, _context) do
    try do
      args
      |> Lore.path([:query, :id])
      |> Accounts.get_user!()
      |> Accounts.update_user(args.user)
      |> Graphql.db_result_to_response(:user)
    rescue
      _exception ->
        Lore.error("Unable to update user")
    end
  end
end
