defmodule GymRat.Climbing.Tick do
  use Ecto.Schema
  import Ecto.Changeset
  alias GymRat.Climbing.Tick

  @whitelist_params [
    :user_id,
    :route_id,
    :user_grade_id,
    :number_tries,
    :rating,
    :send_type,
    :ticked_at
  ]

  @required_params [
    :user_id,
    :route_id,
    :user_grade_id,
    :number_tries,
    :rating,
    :send_type,
    :ticked_at
  ]

  schema "ticks" do
    belongs_to(:user, GymRat.Accounts.User)
    belongs_to(:route, GymRat.RouteManagement.Route)

    # TODO
    field(:user_grade_id, :integer)
    field(:number_tries, :integer)
    field(:rating, :integer)
    field(:send_type, :string)
    field(:ticked_at, :utc_datetime)

    timestamps()
  end

  @doc false
  def changeset(%Tick{} = tick, attrs) do
    tick
    |> cast(attrs, @whitelist_params)
    |> foreign_key_constraint(:route_id)
    |> foreign_key_constraint(:user_id)
    |> validate_required(@required_params)
  end
end
