defmodule GymRat.Repo.Migrations.AlterTick do
  use Ecto.Migration

  def change do
    alter table("ticks") do
      modify :route_id, references(:routes)
      modify :user_id, references(:users)
    end
  end
end
