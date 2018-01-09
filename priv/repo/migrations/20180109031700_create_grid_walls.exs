defmodule GymRat.Repo.Migrations.CreateGridWalls do
  use Ecto.Migration

  def change do
    create table(:grid_walls) do
      add :area_id, references(:areas, on_delete: :nothing), null: false
      add :name, :string, null: false
      add :x_width, :integer, null: false
      add :y_height, :integer, null: false
      add :angle, :float
      add :last_reset_at, :utc_datetime

      timestamps()
    end

    create index(:grid_walls, [:area_id])
  end
end
