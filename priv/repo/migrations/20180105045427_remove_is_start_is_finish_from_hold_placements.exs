defmodule GymRat.Repo.Migrations.RemoveIsStartIsFinishFromHoldPlacements do
  use Ecto.Migration

  def change do
    alter table(:hold_placements) do
      remove(:is_start)
      remove(:is_finish)
    end
  end
end
