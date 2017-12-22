defmodule GymRat.Repo.Migrations.AddRouteName do
  use Ecto.Migration

  def change do
    alter table(:routes) do
      add(:name, :text)
    end
  end
end
