defmodule GymRat.Inventory.Hold do
  use Ecto.Schema
  import Ecto.Changeset
  alias GymRat.Inventory.Hold

  schema "holds" do
    has_many(:hold_placements, GymRat.RouteManagement.HoldPlacement)

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
    |> cast(attrs, [:maker, :color, :size, :count, :material, :features, :primary_use])
    |> validate_required([:maker, :color, :size, :count, :material, :features, :primary_use])
  end
end
