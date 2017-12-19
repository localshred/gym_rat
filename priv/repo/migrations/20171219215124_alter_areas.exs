defmodule GymRat.Repo.Migrations.AlterAreas do
  use Ecto.Migration

  def change do
    alter table("areas") do
      modify :gym_id, references(:gyms)
    end
  end
end
