defmodule GymRat.RouteManagement.Route do
  use Ecto.Schema
  import Ecto.Changeset

  alias GymRat.RouteManagement.Route

  schema "routes" do
    belongs_to :area, GymRat.Facilities.Area
    belongs_to :setter, GymRat.Accounts.User
    has_many :ticks, GymRat.Climbing.Tick
    has_many :hold_placements, GymRat.RouteManagement.HoldPlacement

    field :grade_id, :integer # TODO
    field :name, :string
    field :color, :string
    field :expires_on, :utc_datetime
    field :set_on, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(%Route{} = route, attrs) do
    route
    |> cast(attrs, [:area_id, :setter_id, :name, :color, :grade_id, :set_on, :expires_on])
    |> validate_required([:area_id, :setter_id, :color, :set_on, :expires_on])
  end
end
