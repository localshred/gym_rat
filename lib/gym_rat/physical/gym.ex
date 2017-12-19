defmodule GymRat.Physical.Gym do
  use Ecto.Schema
  import Ecto.Changeset
  alias GymRat.Physical.Gym


  schema "gyms" do
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
