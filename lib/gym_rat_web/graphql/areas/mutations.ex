defmodule GymRatWeb.Graphql.Areas.Mutations do
  use Absinthe.Schema.Notation

  alias GymRat.Facilities
  alias GymRat.Graphql
  alias GymRat.Lore

  input_object :create_area_input do
    field :gym_id, non_null(:integer)
    field :name, non_null(:string)
  end

  object :create_area_response do
    field :area, non_null(:area)
  end

  input_object :update_area_input do
    field :name, non_null(:string)
  end

  object :update_area_response do
    field :area, non_null(:area)
  end

  object :areas_mutations do
    field :create_area, non_null(:create_area_response) do
      arg :query, non_null(:create_area_input)
      resolve &create_area/2
    end

    field :delete_area, non_null(:delete_record_response) do
      arg :query, non_null(:get_record_input)
      resolve &delete_area/2
    end

    field :update_area, non_null(:update_area_response) do
      arg :query, non_null(:get_record_input)
      arg :update, non_null(:update_area_input)
      resolve &update_area/2
    end
  end

  def create_area(args, _context) do
    args
    |> Lore.prop(:area)
    |> Facilities.create_area()
    |> Graphql.db_result_to_response(:area)
  end

  def delete_area(args, _context) do
    args
    |> Lore.path([:query, :id])
    |> Facilities.get_area()
    |> Graphql.delete_record(&Facilities.delete_area/1)
  end

  def update_area(args, _context)  do
    try do
      args
      |> Lore.path([:query, :id])
      |> Facilities.get_area!()
      |> Facilities.update_area(args.update)
      |> Graphql.db_result_to_response(:area)
    rescue exception ->
      Lore.error("Unable to update area")
    end
  end
end

