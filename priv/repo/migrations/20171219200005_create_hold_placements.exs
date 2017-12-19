defmodule GymRat.Repo.Migrations.CreateHoldPlacements do
  use Ecto.Migration

  def change do
    create table(:hold_placements) do
      add :route_id, :integer
      add :hold_id, :integer
      add :grid_coordinate_x, :integer
      add :grid_coordinate_y, :integer
      add :is_start, :boolean, default: false, null: false
      add :is_finish, :boolean, default: false, null: false

      timestamps()
    end

  end
end
