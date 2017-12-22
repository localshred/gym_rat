defmodule GymRat.RouteManagement.Grade do
  use Ecto.Schema
  import Ecto.Changeset

  alias GymRat.RouteManagement.Grade

  @required_params [:system, :major]

  @whitelist_params [:system, :major, :minor, :difficulty]

  schema "grades" do
    field :difficulty, :string
    field :major, :string, null: false
    field :minor, :string
    field :system, :string, null: false

    timestamps()
  end

  @doc false
  def changeset(%Grade{} = grade, attrs) do
    grade
    |> cast(attrs, @whitelist_params)
    |> validate_required(@required_params)
  end
end
