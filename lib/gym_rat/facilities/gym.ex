defmodule GymRat.Facilities.Gym do
  use Ecto.Schema
  import Ecto.Changeset

  alias GymRat.Facilities.Gym

  @whitelist_params [:name, :website, :address]
  @required_params [:name, :website]

  schema "gyms" do
    has_many(:areas, GymRat.Facilities.Area)

    field(:address, :string)
    field(:name, :string, null: false)
    field(:website, :string, null: false)

    timestamps()
  end

  @doc false
  def changeset(%Gym{} = gym, attrs) do
    gym
    |> cast(attrs, @whitelist_params)
    |> validate_required(@required_params)
  end
end
