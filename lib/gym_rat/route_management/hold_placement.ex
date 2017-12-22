defmodule GymRat.RouteManagement.HoldPlacement do
  use Ecto.Schema
  import Ecto.Changeset

  alias GymRat.RouteManagement.HoldPlacement

  @whitelist_params [
    :hold_id,
    :grid_coordinate_x,
    :grid_coordinate_y,
    :is_start,
    :is_finish
  ]

  @required_params [
    :hold_id,
    :grid_coordinate_x,
    :grid_coordinate_y,
    :is_start,
    :is_finish
  ]

  schema "hold_placements" do
    belongs_to(:hold, GymRat.Inventory.Hold)

    field(:grid_coordinate_x, :integer)
    field(:grid_coordinate_y, :integer)
    field(:is_finish, :boolean, default: false)
    field(:is_start, :boolean, default: false)

    timestamps()
  end

  @doc false
  def changeset(%HoldPlacement{} = hold_placement, attrs) do
    hold_placement
    |> cast(attrs, @whitelist_params)
    |> foreign_key_constraint(:hold_id)
    |> validate_required(@required_params)
  end
end
