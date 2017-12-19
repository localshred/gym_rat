defmodule GymRat.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias GymRat.Accounts.User


  schema "users" do
    field :email, :string
    field :name, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :username])
    |> validate_required([:name, :email, :username])
  end
end
