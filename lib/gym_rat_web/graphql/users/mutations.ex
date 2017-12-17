defmodule GymRatWeb.GraphQL.Users.Mutations do
  use Absinthe.Schema.Notation

  input_object :create_user_input do
    field :name, :string
    field :username, non_null(:string)
    field :email, non_null(:string)
    field :password, non_null(:string)
    field :password_confirmation, non_null(:string)
  end

  object :create_user_response do
    field :user, non_null(:user)
  end

  input_object :update_user_input do
    field :name, :string
    field :username, non_null(:string)
    field :email, non_null(:string)
  end

  object :update_user_response do
    field :user, non_null(:user)
  end

  object :users_mutations do
    field :create_user, non_null(:create_user_response) do
      arg :query, non_null(:create_user_input)
      # TODO resolve
    end

    field :delete_user, non_null(:delete_record_response) do
      arg :query, non_null(:get_record_input)
      # TODO resolve
    end

    field :update_user, non_null(:update_user_response) do
      arg :query, non_null(:get_record_input)
      arg :update, non_null(:update_user_input)
      # TODO resolve
    end
  end
end

