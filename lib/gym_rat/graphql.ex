defmodule GymRat.Graphql do
  alias GymRat.Lore

  def db_result_to_response({:ok, data}, prop) do
    data
    |> Lore.assoc_prop(prop)
    |> Lore.ok()
  end

  def db_result_to_response({:error, _} = error, _prop) do
    error
  end

  def delete_record(nil, _delete_fn) do
    %{success: false, deleted_count: 0}
    |> Lore.ok()
  end

  def delete_record(record, delete_fn) when is_map(record) do
    record
    |> delete_fn.()
    |> db_delete_response()
  end

  def db_delete_response({:ok, _resource}) do
    %{success: true, deleted_count: 1}
    |> Lore.ok()
  end

  def db_delete_response({:error, _resource} = error) do
    error
  end

  def enum_value_resolver(field) do
    fn (parent, _args, _context) ->
      parent
      |> Lore.prop(field)
      |> to_atom()
      |> Lore.ok()
    end
  end

  def to_atom(value) when is_binary(value) do
    String.to_atom(value)
  end

  def to_atom(nil) do
    nil
  end
end
