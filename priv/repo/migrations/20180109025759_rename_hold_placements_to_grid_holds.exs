defmodule GymRat.Repo.Migrations.RenameHoldPlacementsToGridHolds do
  use Ecto.Migration

  def change do
    drop table(:hold_placements)

    create table(:grid_holds) do
      add :area_id, references(:areas), null: false
      add :hold_id, references(:holds), null: false

      add :grid_coordinate_x, :float, null: false
      add :grid_coordinate_y, :float, null: false

      timestamps()
    end
  end
end
