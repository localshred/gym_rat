defmodule GymRat.Repo.Migrations.AddAreaToHoldPlacements do
  use Ecto.Migration

  def change do
    alter table(:hold_placements) do
      add(:area_id, references(:areas))
    end
  end
end
