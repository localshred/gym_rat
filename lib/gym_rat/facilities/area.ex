defmodule GymRat.RouteManagement.Area do
  use Ecto.Schema
  import Ecto.Changeset
  alias GymRat.RouteManagement.Area


  schema "areas" do
    field :gym_id, :integer
    field :name, :string
    field :order, :integer

    timestamps()
  end

  @doc false
  def changeset(%Area{} = area, attrs) do
    area
    |> cast(attrs, [:gym_id, :name, :order])
    |> validate_required([:gym_id, :name, :order])
  end
end
