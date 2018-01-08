defmodule GymRat.Inventory do
  @moduledoc """
  The Inventory context.
  """

  alias GymRat.Inventory.Context.Hold
  defdelegate change_hold(hold), to: Hold
  defdelegate count_holds, to: Hold
  defdelegate create_hold(attrs), to: Hold
  defdelegate delete_hold(hold), to: Hold
  defdelegate find_or_create_hold!(hold), to: Hold
  defdelegate get_hold!(id), to: Hold
  defdelegate get_hold(id), to: Hold
  defdelegate list_holds(ids), to: Hold
  defdelegate list_holds, to: Hold
  defdelegate update_hold(hold, attrs), to: Hold
end
