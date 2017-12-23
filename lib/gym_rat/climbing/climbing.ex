defmodule GymRat.Climbing do
  @moduledoc """
  The Climbing context.
  """

  alias GymRat.Climbing.Context.Tick
  defdelegate change_tick(tick), to: Tick
  defdelegate create_tick(attrs), to: Tick
  defdelegate delete_tick(tick), to: Tick
  defdelegate get_tick!(id), to: Tick
  defdelegate get_tick(id), to: Tick
  defdelegate list_ticks(ids), to: Tick
  defdelegate list_ticks, to: Tick
  defdelegate update_tick(tick, attrs), to: Tick
end
