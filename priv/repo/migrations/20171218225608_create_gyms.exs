defmodule GymRat.Repo.Migrations.CreateGyms do
  use Ecto.Migration

  def change do
    create table(:gyms) do
      add :name, :string, null: false
      add :website, :text, null: false
      add :address, :text

      timestamps()
    end

  end
end
