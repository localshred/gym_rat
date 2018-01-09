defmodule GymRat.TestFactories do
  use ExMachina.Ecto, repo: GymRat.Repo

  use GymRat.TestFactories.Accounts
  use GymRat.TestFactories.Climbing
  use GymRat.TestFactories.Facilities
  use GymRat.TestFactories.Inventory
  use GymRat.TestFactories.RouteManagement
  use GymRat.TestFactories.WallManagement
end
