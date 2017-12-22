defmodule GymRat.Repo.Migrations.CreateHolds do
  use Ecto.Migration

  def change do
    create table(:holds) do
      add(:maker, :string)
      add(:color, :string)
      add(:size, :string)
      add(:count, :integer)
      add(:material, :string)
      add(:features, :string)
      add(:primary_use, :string)

      timestamps()
    end
  end
end
