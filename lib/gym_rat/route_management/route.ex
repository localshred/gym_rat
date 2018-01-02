defmodule GymRat.RouteManagement.Route do
  use Ecto.Schema
  import Ecto.Changeset

  alias GymRat.RouteManagement.Route

  @whitelist_params [:area_id, :grade_id, :setter_id, :name, :color, :set_on, :expires_on]

  @required_params [:area_id, :grade_id, :setter_id, :color, :set_on, :expires_on]

  schema "routes" do
    belongs_to(:area, GymRat.Facilities.Area)
    belongs_to(:grade, GymRat.RouteManagement.Grade)
    belongs_to(:setter, GymRat.Accounts.User)
    has_many(:ticks, GymRat.Climbing.Tick)

    field(:name, :string)
    field(:color, :string)
    field(:expires_on, :utc_datetime)
    field(:set_on, :utc_datetime)

    timestamps()
  end

  @doc false
  def changeset(%Route{} = route, attrs) do
    route
    |> cast(attrs, @whitelist_params)
    |> foreign_key_constraint(:area_id)
    |> foreign_key_constraint(:grade_id)
    |> foreign_key_constraint(:setter_id)
    |> validate_required(@required_params)
  end
end
