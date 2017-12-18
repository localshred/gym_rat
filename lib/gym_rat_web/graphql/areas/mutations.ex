defmodule GymRatWeb.Graphql.Areas.Mutations do
  use Absinthe.Schema.Notation

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
      # TODO resolve
    end

    field :delete_area, non_null(:delete_record_response) do
      arg :query, non_null(:get_record_input)
      # TODO resolve
    end

    field :update_area, non_null(:update_area_response) do
      arg :query, non_null(:get_record_input)
      arg :update, non_null(:update_area_input)
      # TODO resolve
    end
  end
end

