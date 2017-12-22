defmodule GymRat.Repo.Migrations.CreateAreas do
  use Ecto.Migration

  def change do
    create table(:areas) do
      add(:gym_id, :integer)
      add(:name, :string)
      add(:order, :integer)

      timestamps()
    end
  end
end
