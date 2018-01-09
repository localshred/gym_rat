defmodule GymRat.WallManagement.GridWall do
  use Ecto.Schema
  import Ecto.Changeset

  alias GymRat.WallManagement.GridWall

  @required_params [:area_id, :name, :x_width, :y_height]

  @whitelist_params [:area_id, :name, :x_width, :y_height, :angle, :last_reset_at]

  schema "grid_walls" do
    belongs_to(:area, GymRat.Facilities.Area)

    field(:angle, :float)
    field(:last_reset_at, :utc_datetime)
    field(:name, :string, null: false)
    field(:x_width, :integer, null: false)
    field(:y_height, :integer, null: false)

    timestamps()
  end

  @doc false
  def changeset(%GridWall{} = grid_wall, attrs) do
    grid_wall
    |> cast(attrs, @whitelist_params)
    |> foreign_key_constraint(:area_id)
    |> validate_required(@required_params)
  end
end
