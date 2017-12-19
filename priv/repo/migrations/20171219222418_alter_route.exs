defmodule GymRat.Repo.Migrations.AlterRoute do
  use Ecto.Migration

  def change do
    alter table(:routes) do
      modify :area_id, references(:areas), null: false
      modify :setter_id, references(:users), null: false
      remove :set_onetime
      add :set_on, :time, null: false
    end
  end
end
