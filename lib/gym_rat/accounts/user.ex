defmodule GymRat.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias GymRat.Accounts.User

  @required_params [:name, :email, :username]

  @whitelist_params [:name, :email, :username]

  schema "users" do
    has_many(:ticks, GymRat.Climbing.Tick)
    field(:email, :string)
    field(:name, :string)
    field(:username, :string)

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @whitelist_params)
    |> validate_required(@required_params)
  end
end
