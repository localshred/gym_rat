defmodule GymRat.Repo.Migrations.FixDateTimeColumns do
  use Ecto.Migration

  def change do
    alter table(:routes) do
      remove :set_on
      remove :expires_on
      add :set_on, :utc_datetime, null: false
      add :expires_on, :utc_datetime, null: false
    end
    alter table(:ticks) do
      remove :sent_on
      add :ticked_at, :utc_datetime, null: false
    end
  end
end
