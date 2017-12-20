defmodule GymRat.RouteManagement.HoldPlacement do
  use Ecto.Schema
  import Ecto.Changeset
  alias GymRat.RouteManagement.HoldPlacement


  schema "hold_placements" do
    belongs_to :hold, GymRat.Inventory.Hold
    belongs_to :route, GymRat.RouteManagement.Route

    field :grid_coordinate_x, :integer
    field :grid_coordinate_y, :integer
    field :is_finish, :boolean, default: false
    field :is_start, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%HoldPlacement{} = hold_placement, attrs) do
    hold_placement
    |> cast(attrs, [:route_id, :hold_id, :grid_coordinate_x, :grid_coordinate_y, :is_start, :is_finish])
    |> foreign_key_constraint(:route_id)
    |> foreign_key_constraint(:hold_id)
    |> validate_required([:route_id, :hold_id, :grid_coordinate_x, :grid_coordinate_y, :is_start, :is_finish])
  end
end
