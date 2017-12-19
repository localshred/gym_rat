defmodule GymRat.RouteManagement.Route do
  use Ecto.Schema
  import Ecto.Changeset
  alias GymRat.RouteManagement.Route


  schema "routes" do
    field :area_id, :integer
    field :color, :string
    field :expires_on, :time
    field :grade_id, :integer
    field :set_onetime, :string
    field :setter_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%Route{} = route, attrs) do
    route
    |> cast(attrs, [:area_id, :setter_id, :color, :grade_id, :set_onetime, :expires_on])
    |> validate_required([:area_id, :setter_id, :color, :grade_id, :set_onetime, :expires_on])
  end
end
