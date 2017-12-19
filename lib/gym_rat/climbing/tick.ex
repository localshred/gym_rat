defmodule GymRat.Climbing.Tick do
  use Ecto.Schema
  import Ecto.Changeset
  alias GymRat.Climbing.Tick


  schema "ticks" do
    belongs_to :user, GymRat.Accounts.User
    belongs_to :route, GymRat.RouteManagement.Route

    field :user_grade_id, :integer # TODO
    field :number_tries, :integer
    field :rating, :integer
    field :send_type, :string
    field :sent_on, :time

    timestamps()
  end

  @doc false
  def changeset(%Tick{} = tick, attrs) do
    tick
    |> cast(attrs, [:user_id, :route_id, :user_grade_id, :number_tries, :rating, :send_type, :sent_on])
    |> validate_required([:user_id, :route_id, :user_grade_id, :number_tries, :rating, :send_type, :sent_on])
  end
end
