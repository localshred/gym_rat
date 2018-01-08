defmodule GymRat.RouteManagement.HoldPlacement do
  use Ecto.Schema
  import Ecto.Changeset

  alias GymRat.RouteManagement.HoldPlacement

  @whitelist_params [
    :area_id,
    :hold_id,
    :grid_coordinate_x,
    :grid_coordinate_y
  ]

  @required_params [
    :area_id,
    :hold_id,
    :grid_coordinate_x,
    :grid_coordinate_y
  ]

  schema "hold_placements" do
    belongs_to(:area, GymRat.Facilities.Area)
    belongs_to(:hold, GymRat.Inventory.Hold)

    field(:grid_coordinate_x, :float, null: false)
    field(:grid_coordinate_y, :float, null: false)

    timestamps()
  end

  @doc false
  def changeset(%HoldPlacement{} = hold_placement, attrs) do
    hold_placement
    |> cast(attrs, @whitelist_params)
    |> foreign_key_constraint(:area_id)
    |> foreign_key_constraint(:hold_id)
    |> validate_required(@required_params)
  end
end
