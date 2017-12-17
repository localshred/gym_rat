defmodule GymRatWeb.GraphQL.Ticks.Mutations do
  use Absinthe.Schema.Notation

  input_object :create_tick_input do
    # TODO
  end

  object :create_tick_response do
    field :tick, non_null(:tick)
  end

  input_object :update_tick_input do
    # TODO
  end

  object :update_tick_response do
    field :tick, non_null(:tick)
  end

  object :ticks_mutations do
    field :create_tick, non_null(:create_tick_response) do
      arg :query, non_null(:create_tick_input)
      # TODO resolve
    end

    field :delete_tick, non_null(:delete_record_response) do
      arg :query, non_null(:get_record_input)
      # TODO resolve
    end

    field :update_tick, non_null(:update_tick_response) do
      arg :query, non_null(:get_record_input)
      arg :update, non_null(:update_tick_input)
      # TODO resolve
    end
  end
end

