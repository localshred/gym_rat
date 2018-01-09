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
end
