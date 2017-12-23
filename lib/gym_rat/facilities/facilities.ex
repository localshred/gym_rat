defmodule GymRat.Facilities do
  @moduledoc """
  The Facilities context.
  """

  alias GymRat.Facilities.Context.Area
  defdelegate change_area(area), to: Area
  defdelegate create_area(attrs), to: Area
  defdelegate delete_area(area), to: Area
  defdelegate get_area!(id), to: Area
  defdelegate get_area(id), to: Area
  defdelegate list_areas(ids), to: Area
  defdelegate list_areas, to: Area
  defdelegate update_area(area, attrs), to: Area

  alias GymRat.Facilities.Context.Gym
  defdelegate change_gym(gym), to: Gym
  defdelegate count_gyms, to: Gym
  defdelegate create_gym(attrs), to: Gym
  defdelegate delete_gym(gym), to: Gym
  defdelegate get_gym!(id), to: Gym
  defdelegate get_gym(id), to: Gym
  defdelegate list_gyms(ids), to: Gym
  defdelegate list_gyms, to: Gym
  defdelegate update_gym(gym, attrs), to: Gym
end
