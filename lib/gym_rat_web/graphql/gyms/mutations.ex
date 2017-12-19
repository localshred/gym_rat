defmodule GymRatWeb.Graphql.Gyms.Mutations do
  use Absinthe.Schema.Notation

  alias GymRat.Physical
  alias GymRat.Lore
  alias GymRat.Graphql

  input_object :create_gym_input do
    field :name, non_null(:string)
    field :website, non_null(:string)
    field :address, :string
  end

  object :create_gym_response do
    field :gym, non_null(:gym)
  end

  input_object :update_gym_input do
    field :name, :string
    field :website, :string
    field :address, :string
  end

  object :update_gym_response do
    field :gym, non_null(:gym)
  end

  object :gyms_mutations do
    field :create_gym, non_null(:create_gym_response) do
      arg :gym, non_null(:create_gym_input)

      resolve fn
        (args, _context) ->
          args
          |> Lore.prop(:gym)
          |> Physical.create_gym()
          |> Graphql.db_result_to_response(:gym)
      end
    end

    field :delete_gym, non_null(:delete_record_response) do
      arg :query, non_null(:get_record_input)

      resolve fn
        (args, _context) ->
          args
          |> Lore.path([:query, :id])
          |> Physical.get_gym()
          |> Graphql.delete_record(&Physical.delete_gym/1)
      end
    end

    field :update_gym, non_null(:update_gym_response) do
      arg :query, non_null(:get_record_input)
      arg :update, non_null(:update_gym_input)

      resolve fn
        (args, _context) ->
          try do
            args
            |> Lore.path([:query, :id])
            |> Lore.inspect(:id)
            |> Physical.get_gym!()
            |> Lore.inspect(:gym)
            |> Physical.update_gym(args.update)
            |> Graphql.db_result_to_response(:gym)
          rescue exception ->
            Lore.error("Unable to update gym")
          end
      end
    end
  end
end

