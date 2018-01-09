defmodule GymRat.WallManagement do
  @moduledoc """
  The WallManagement context for working with GridHolds.
  """

  alias GymRat.WallManagement.Context.GridHold
  defdelegate change_grid_hold(grid_hold), to: GridHold
  defdelegate count_grid_holds, to: GridHold
  defdelegate create_grid_hold(attrs), to: GridHold
  defdelegate delete_grid_hold(grid_hold), to: GridHold
  defdelegate get_grid_hold!(id), to: GridHold
  defdelegate get_grid_hold(id), to: GridHold
  defdelegate list_grid_holds(ids), to: GridHold
  defdelegate list_grid_holds, to: GridHold
  defdelegate update_grid_hold(grid_hold, attrs), to: GridHold

  alias GymRat.WallManagement.Context.GridWall
  defdelegate change_grid_wall(grid_wall), to: GridWall
  defdelegate count_grid_walls, to: GridWall
  defdelegate create_grid_wall(attrs), to: GridWall
  defdelegate delete_grid_wall(grid_wall), to: GridWall
  defdelegate get_grid_wall!(id), to: GridWall
  defdelegate get_grid_wall(id), to: GridWall
  defdelegate list_grid_walls(ids), to: GridWall
  defdelegate list_grid_walls, to: GridWall
  defdelegate update_grid_wall(grid_wall, attrs), to: GridWall
end
