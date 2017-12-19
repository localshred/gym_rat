defmodule GymRatWeb.Graphql.Holds.Mutations do
  use Absinthe.Schema.Notation

  alias GymRat.Graphql
  alias GymRat.Inventory
  alias GymRat.Lore

  input_object :create_hold_input do
    field :maker, non_null(:string)
    field :color, non_null(:string)
    field :size, non_null(:string)
    field :count, :integer
    field :material, :material
    field :features, :string
    field :primary_use, :hold_type
  end

  object :create_hold_response do
    field :hold, non_null(:hold)
  end

  input_object :update_hold_input do
    field :maker, :string
    field :color, :string
    field :count, :integer
    field :size, :string
    field :material, :material
    field :features, :string
    field :primary_use, :hold_type
  end

  object :update_hold_response do
    field :hold, non_null(:hold)
  end

  object :holds_mutations do
    field :create_hold, non_null(:create_hold_response) do
      arg :hold, non_null(:create_hold_input)
      resolve &create_hold/2
    end

    field :delete_hold, non_null(:delete_record_response) do
      arg :query, non_null(:get_record_input)
      resolve &delete_hold/2
    end

    field :update_hold, non_null(:update_hold_response) do
      arg :query, non_null(:get_record_input)
      arg :hold, non_null(:update_hold_input)
      resolve &update_hold/2
    end
  end

  def create_hold(args, _context) do
    args
    |> Lore.prop(:hold)
    |> Inventory.create_hold()
    |> Graphql.db_result_to_response(:hold)
  end

  def delete_hold(args, _context) do
    args
    |> Lore.path([:query, :id])
    |> Inventory.get_hold()
    |> Graphql.delete_record(&Inventory.delete_hold/1)
  end

  def update_hold(args, _context)  do
    try do
      args
      |> Lore.path([:query, :id])
      |> Inventory.get_hold!()
      |> Inventory.update_hold(args.update)
      |> Graphql.db_result_to_response(:hold)
    rescue exception ->
      Lore.error("Unable to update hold")
    end
  end
end

