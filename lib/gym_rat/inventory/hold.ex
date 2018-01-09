defmodule GymRat.Inventory.Hold do
  use Ecto.Schema
  import Ecto.Changeset
  alias GymRat.Inventory.Hold

  @whitelist_params [:maker, :color, :size, :count, :material, :features, :primary_use]

  @required_params [:maker, :color, :size, :count, :material, :features, :primary_use]

  schema "holds" do
    has_many(:grid_holds, GymRat.WallManagement.GridHold)

    field(:color, :string)
    field(:count, :integer)
    field(:features, :string)
    field(:maker, :string)
    field(:material, :string)
    field(:primary_use, :string)
    field(:size, :string)

    timestamps()
  end

  @doc false
  def changeset(%Hold{} = hold, attrs) do
    hold
    |> cast(attrs, @whitelist_params)
    |> validate_required(@required_params)
  end
end
