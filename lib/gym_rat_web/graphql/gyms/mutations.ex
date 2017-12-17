defmodule GymRatWeb.GraphQL.Gyms.Mutations do
  use Absinthe.Schema.Notation

  input_object :create_gym_input do
    # TODO
  end

  object :create_gym_response do
    field :gym, non_null(:gym)
  end

  input_object :update_gym_input do
    # TODO
  end

  object :update_gym_response do
    field :gym, non_null(:gym)
  end

  object :gyms_mutations do
    field :create_gym, non_null(:create_gym_response) do
      arg :query, non_null(:create_gym_input)
      # TODO resolve
    end

    field :delete_gym, non_null(:delete_record_response) do
      arg :query, non_null(:get_record_input)
      # TODO resolve
    end

    field :update_gym, non_null(:update_gym_response) do
      arg :query, non_null(:get_record_input)
      arg :update, non_null(:update_gym_input)
      # TODO resolve
    end
  end
end
