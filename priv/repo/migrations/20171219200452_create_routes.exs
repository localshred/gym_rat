defmodule GymRat.Repo.Migrations.CreateRoutes do
  use Ecto.Migration

  def change do
    create table(:routes) do
      add :area_id, :integer
      add :setter_id, :integer
      add :color, :string
      add :grade_id, :integer
      add :set_onetime, :string
      add :expires_on, :time

      timestamps()
    end

  end
end
