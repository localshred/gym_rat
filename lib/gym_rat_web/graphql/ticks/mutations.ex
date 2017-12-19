defmodule GymRatWeb.Graphql.Ticks.Mutations do
  use Absinthe.Schema.Notation

  alias GymRat.Climbing
  alias GymRat.Graphql
  alias GymRat.Lore

  input_object :create_tick_input do
    field :user_id, non_null(:id)
    field :route_id, non_null(:id)
    field :user_grade, :grade_input
    field :number_tries, :integer
    field :rating, :tick_rating
    field :send_type, non_null(:send_type)
    field :sent_on, non_null(:utc_timestamp)
  end

  object :create_tick_response do
    field :tick, non_null(:tick)
  end

  input_object :update_tick_input do
    field :user_id, :id
    field :route_id, :id
    field :user_grade, :grade_input
    field :number_tries, :integer
    field :rating, :tick_rating
    field :send_type, :send_type
    field :sent_on, :utc_timestamp
  end

  object :update_tick_response do
    field :tick, non_null(:tick)
  end

  object :ticks_mutations do
    field :create_tick, non_null(:create_tick_response) do
      arg :tick, non_null(:create_tick_input)
      resolve &create_tick/2
    end

    field :delete_tick, non_null(:delete_record_response) do
      arg :query, non_null(:get_record_input)
      resolve &delete_tick/2
    end

    field :update_tick, non_null(:update_tick_response) do
      arg :query, non_null(:get_record_input)
      arg :tick, non_null(:update_tick_input)
      resolve &update_tick/2
    end
  end

  def create_tick(args, _context) do
    args
    |> Lore.prop(:tick)
    |> Climbing.create_tick()
    |> Graphql.db_result_to_response(:tick)
  end

  def delete_tick(args, _context) do
    args
    |> Lore.path([:query, :id])
    |> Climbing.get_tick()
    |> Graphql.delete_record(&Climbing.delete_tick/1)
  end

  def update_tick(args, _context)  do
    try do
      args
      |> Lore.path([:query, :id])
      |> Climbing.get_tick!()
      |> Climbing.update_tick(args.update)
      |> Graphql.db_result_to_response(:tick)
    rescue exception ->
      Lore.error("Unable to update tick")
    end
  end
end

