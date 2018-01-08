defmodule GymRat.Repo.Migrations.ChangeHoldPlacementGridToFloats do
  use Ecto.Migration

  def change do
    alter table(:hold_placements) do
      modify(:grid_coordinate_x, :float, null: false)
      modify(:grid_coordinate_y, :float, null: false)
    end
  end
end
