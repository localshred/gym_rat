defmodule GymRatWeb.Graphql.Gyms.Mutations do
  use Absinthe.Schema.Notation

  alias GymRat.Facilities
  alias GymRat.Graphql
  alias GymRat.Lore

  input_object :create_gym_input do
    field(:name, non_null(:string))
    field(:website, non_null(:string))
    field(:address, :string)
  end

  object :create_gym_response do
    field(:gym, non_null(:gym))
  end

  input_object :update_gym_input do
    field(:name, :string)
    field(:website, :string)
    field(:address, :string)
  end

  object :update_gym_response do
    field(:gym, non_null(:gym))
  end

  object :gyms_mutations do
    field :create_gym, non_null(:create_gym_response) do
      arg(:gym, non_null(:create_gym_input))
      resolve(&create_gym/2)
    end

    field :delete_gym, non_null(:delete_record_response) do
      arg(:query, non_null(:get_record_input))
      resolve(&delete_gym/2)
    end

    field :update_gym, non_null(:update_gym_response) do
      arg(:query, non_null(:get_record_input))
      arg(:gym, non_null(:update_gym_input))
      resolve(&update_gym/2)
    end
  end

  def create_gym(args, _context) do
    args
    |> Lore.prop(:gym)
    |> Facilities.create_gym()
    |> Graphql.db_result_to_response(:gym)
  end

  def delete_gym(args, _context) do
    args
    |> Lore.path([:query, :id])
    |> Facilities.get_gym()
    |> Graphql.delete_record(&Facilities.delete_gym/1)
  end

  def update_gym(args, _context) do
    try do
      args
      |> Lore.path([:query, :id])
      |> Facilities.get_gym!()
      |> Facilities.update_gym(args.gym)
      |> Graphql.db_result_to_response(:gym)
    rescue
      _exception ->
        Lore.error("Unable to update gym")
    end
  end
end
