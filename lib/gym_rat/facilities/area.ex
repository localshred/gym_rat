defmodule GymRat.Facilities.Area do
  use Ecto.Schema
  import Ecto.Changeset

  alias GymRat.Facilities.Area

  schema "areas" do
    belongs_to :gym, GymRat.Facilities.Gym
    has_many :routes, GymRat.RouteManagement.Route

    field :name, :string, null: false
    field :order, :integer, null: false, default: 0

    timestamps()
  end

  @doc false
  def changeset(%Area{} = area, attrs) do
    area
    |> cast(attrs, [:gym_id, :name, :order])
    |> validate_required([:gym_id, :name])
  end
end
