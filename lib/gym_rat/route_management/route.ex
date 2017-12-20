defmodule GymRat.RouteManagement.Route do
  use Ecto.Schema
  import Ecto.Changeset
  alias GymRat.RouteManagement.Route


  schema "routes" do
    belongs_to :area, Ecto.Facilities.Area
    belongs_to :setter, Ecto.Accounts.User
    has_many :hold_placements, Ecto.RouteManagement.HoldPlacement
    belongs_to :setter, GymRat.Accounts.User

    field :grade_id, :integer # TODO
    field :color, :string
    field :expires_on, :time
    field :set_on, :time

    timestamps()
  end

  @doc false
  def changeset(%Route{} = route, attrs) do
    route
    |> cast(attrs, [:area_id, :setter_id, :name, :color, :grade_id, :set_on, :expires_on])
    |> validate_required([:area_id, :setter_id, :color, :set_on, :expires_on])
  end
end
