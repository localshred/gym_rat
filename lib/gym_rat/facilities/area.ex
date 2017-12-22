defmodule GymRat.Facilities.Area do
  use Ecto.Schema
  import Ecto.Changeset

  alias GymRat.Facilities.Area

  @required_params [:gym_id, :name]

  @whitelist_params [:gym_id, :name, :order]

  schema "areas" do
    belongs_to(:gym, GymRat.Facilities.Gym)
    has_many(:routes, GymRat.RouteManagement.Route)

    field(:name, :string, null: false)
    field(:order, :integer, null: false, default: 0)

    timestamps()
  end

  @doc false
  def changeset(%Area{} = area, attrs) do
    area
    |> cast(attrs, @whitelist_params)
    |> foreign_key_constraint(:gym_id)
    |> validate_required(@required_params)
  end
end
