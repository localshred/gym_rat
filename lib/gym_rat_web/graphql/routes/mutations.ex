defmodule GymRatWeb.GraphQL.Routes.Mutations do
  use Absinthe.Schema.Notation

  input_object :grade_input do
    field :system, non_null(:grade_system)
    field :major, non_null(:string)
    field :minor, :string
    field :tiny, :string
    field :difficulty, :grade_difficulty
  end

  input_object :create_route_input do
    field :area_id, non_null(:integer)
    field :setter_id, non_null(:integer)
    field :color, non_null(:string)
    field :grade, non_null(:grade_input)
    field :set_on, non_null(:utc_timestamp)
    field :expires_on, :utc_timestamp
  end

  object :create_route_response do
    field :route, non_null(:route)
  end

  input_object :update_route_input do
    field :area_id, :integer
    field :setter_id, :integer
    field :color, :string
    field :grade, :grade_input
    field :set_on, :utc_timestamp
    field :expires_on, :utc_timestamp
  end

  object :update_route_response do
    field :route, non_null(:route)
  end

  object :routes_mutations do
    field :create_route, non_null(:create_route_response) do
      arg :query, non_null(:create_route_input)
      # TODO resolve
    end

    field :delete_route, non_null(:delete_record_response) do
      arg :query, non_null(:get_record_input)
      # TODO resolve
    end

    field :update_route, non_null(:update_route_response) do
      arg :query, non_null(:get_record_input)
      arg :update, non_null(:update_route_input)
      # TODO resolve
    end
  end
end

