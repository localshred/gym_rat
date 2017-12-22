defmodule GymRat.Repo.Migrations.AlterHoldPlacements do
  use Ecto.Migration

  def change do
    alter table(:hold_placements) do
      modify(:hold_id, references(:holds))
      modify(:route_id, references(:routes))
    end
  end
end
