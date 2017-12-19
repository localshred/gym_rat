defmodule GymRat.Facilities.Gym do
  use Ecto.Schema
  import Ecto.Changeset

  alias GymRat.Facilities.Gym

  schema "gyms" do
    has_many :areas, GymRat.Facilities.Area

    field :address, :string
    field :name, :string, null: false
    field :website, :string, null: false

    timestamps()
  end

  @doc false
  def changeset(%Gym{} = gym, attrs) do
    gym
    |> cast(attrs, [:name, :website, :address])
    |> validate_required([:name, :website])
  end
end
