defmodule GymRatWeb.Graphql.Users.Queries do
  use Absinthe.Schema.Notation

  object :user_response do
    field :user, non_null(:user)
  end

  object :users_response do
    field :users, :user |> non_null |> list_of |> non_null
  end

  object :users_queries do
    field :users, non_null(:users_response) do
      arg :query, non_null(:get_records_input)
      resolve fn (_, args, _resolution) ->
        {:ok, %{
          users: [
            %{
              id: "123",
              name: "BJ Neilsen",
              username: "localshred",
              email: "bj.neilsen@gmail.com"
            }
          ]
        }}
      end
    end

    field :user, non_null(:user_response) do
      arg :query, non_null(:get_record_input)
      resolve fn (_, args, _resolution) ->
        {:ok, %{
          user: %{
            id: "123",
            name: "BJ Neilsen",
            username: "localshred",
            email: "bj.neilsen@gmail.com"
          }
        }}
      end
    end
  end
end
