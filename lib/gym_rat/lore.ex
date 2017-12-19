defmodule GymRat.Lore do
  @moduledoc """
  GymRat.Lore is a module for interacting with data more efficiently through pipes.
  It's loosely patterned after Ramda.js, though of course with "data-first" instead of "data-last".

    "The reign of biological lifeforms is coming to an end..."
    – Lore, 2370 ("Descent, Part II")
  """

  @doc """
  Return a Map with a single key-value pair in it.
  """
  def assoc_prop(value, key) do
    %{}
    |> Map.put(key, value)
  end

  @doc """
  Returns the given value, or the default if the value is not falsey.
  """
  def default_to(value, default_value) do
    value || default_value
  end

  @doc """
  Returns an :error tuple with the given result in the second position.
  """
  def error(result) do
    { :error, result }
  end

  @doc """
  Inspects the given data, wrapped in a Map with the given tag as a key. Very useful inside
  a pipe chain to inspect and "Tag" the data at various parts of the chain.
  """
  def inspect(data, tag) do
    %{}
    |> Map.put(tag, data)
    |> IO.inspect()

    data
  end

  @doc """
  Simply a wrapper around IO.inspect, since you may not want to tag the data.
  """
  def inspect(data) do
    IO.inspect(data)
  end

  @doc """
  Returns an :ok tuple with the given result in the second position.
  """
  def ok(result) do
    { :ok, result }
  end

  @doc """
  Synonymous with Map.get.
  """
  def prop(%{} = map, key) do
    Map.get(map, key)
  end

  @doc """
  Gets the value at the given path from a series of nested Maps, or nil if any of the keys is not found.
  """
  def path(%{} = map, key_path) do
    [initial_key | rest] = key_path
    initial = Map.get(map, initial_key)
    Enum.reduce(rest, initial, fn
      (key, %{} = inner) -> Map.get(inner, key)
      (_key, inner) -> inner
    end)
  end
end
