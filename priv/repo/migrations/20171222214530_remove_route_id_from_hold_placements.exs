defmodule GymRat.Repo.Migrations.RemoveRouteIdFromHoldPlacements do
  use Ecto.Migration

  def change do
    alter table(:hold_placements) do
      remove(:route_id)
    end
  end
end
