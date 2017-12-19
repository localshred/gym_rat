defmodule GymRat.RouteManagement.HoldPlacement do
  use Ecto.Schema
  import Ecto.Changeset
  alias GymRat.RouteManagement.HoldPlacement


  schema "hold_placements" do
    field :grid_coordinate_x, :integer
    field :grid_coordinate_y, :integer
    field :hold_id, :integer
    field :is_finish, :boolean, default: false
    field :is_start, :boolean, default: false
    field :route_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%HoldPlacement{} = hold_placement, attrs) do
    hold_placement
    |> cast(attrs, [:route_id, :hold_id, :grid_coordinate_x, :grid_coordinate_y, :is_start, :is_finish])
    |> validate_required([:route_id, :hold_id, :grid_coordinate_x, :grid_coordinate_y, :is_start, :is_finish])
  end
end
