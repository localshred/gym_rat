defmodule GymRat.Repo.Migrations.RenameHoldPlacementsToGridHolds do
  use Ecto.Migration

  def change do
    rename table(:hold_placements), to: table(:grid_holds)
  end
end
