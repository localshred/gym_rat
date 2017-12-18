defmodule GymRatWeb.Graphql.Holds.Mutations do
  use Absinthe.Schema.Notation

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
      arg :query, non_null(:create_hold_input)
      # TODO resolve
    end

    field :delete_hold, non_null(:delete_record_response) do
      arg :query, non_null(:get_record_input)
      # TODO resolve
    end

    field :update_hold, non_null(:update_hold_response) do
      arg :query, non_null(:get_record_input)
      arg :update, non_null(:update_hold_input)
      # TODO resolve
    end
  end
end

