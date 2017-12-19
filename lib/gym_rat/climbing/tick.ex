defmodule GymRat.Climbing.Tick do
  use Ecto.Schema
  import Ecto.Changeset
  alias GymRat.Climbing.Tick


  schema "ticks" do
    field :number_tries, :integer
    field :rating, :integer
    field :route_id, :integer
    field :send_type, :string
    field :sent_on, :time
    field :user_grade_id, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%Tick{} = tick, attrs) do
    tick
    |> cast(attrs, [:user_id, :route_id, :user_grade_id, :number_tries, :rating, :send_type, :sent_on])
    |> validate_required([:user_id, :route_id, :user_grade_id, :number_tries, :rating, :send_type, :sent_on])
  end
end
