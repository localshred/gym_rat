defmodule GymRat.Repo.Migrations.CreateGrades do
  use Ecto.Migration

  def change do
    create table(:grades) do
      add(:system, :string, null: false)
      add(:major, :string, null: false)
      add(:minor, :string)
      add(:difficulty, :string)

      timestamps()
    end
  end
end
