defmodule GymRat.Repo.Migrations.CreateTicks do
  use Ecto.Migration

  def change do
    create table(:ticks) do
      add(:user_id, :integer)
      add(:route_id, :integer)
      add(:user_grade_id, :integer)
      add(:number_tries, :integer)
      add(:rating, :integer)
      add(:send_type, :string)
      add(:sent_on, :time)

      timestamps()
    end
  end
end
