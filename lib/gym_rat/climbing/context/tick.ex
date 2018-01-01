defmodule GymRat.Climbing.Context.Tick do
  @moduledoc """
  The Climbing.Tick sub-context.
  """

  import Ecto.Query, warn: false
  alias GymRat.Repo

  alias GymRat.Climbing.Tick

  @doc """
  Returns the count of the number of records in the ticks table.

  ## Examples

      iex> count_ticks()
      42

  """
  def count_ticks do
    from(g in "ticks")
    |> Repo.aggregate(:count, :id)
  end

  @doc """
  Returns the list of ticks.

  ## Examples

      iex> list_ticks()
      [%Tick{}, ...]

  """
  def list_ticks do
    Repo.all(Tick)
  end

  @doc """
  Gets a list of ticks by the given IDs.

  ## Examples

      iex> list_ticks([123, 456])
      [%Tick{id: 123}, %Tick{id: 456}]

      iex> list_ticks([])
      []

  """
  def list_ticks(ids) when is_list(ids) and length(ids) > 0 do
    Tick
    |> where([tick], tick.id in ^ids)
    |> Repo.all()
  end

  def list_ticks([]) do
    Repo.all(Tick)
  end

  @doc """
  Gets a single tick or nil if no tick exists for the given id.

  ## Examples

      iex> get_tick(123)
      %Tick{}

      iex> get_tick(456)
      nil

  """
  def get_tick(id), do: Repo.get(Tick, id)

  @doc """
  Gets a single tick.

  Raises `Ecto.NoResultsError` if the Tick does not exist.

  ## Examples

      iex> get_tick!(123)
      %Tick{}

      iex> get_tick!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tick!(id), do: Repo.get!(Tick, id)

  @doc """
  Creates a tick.

  ## Examples

      iex> create_tick(%{field: value})
      {:ok, %Tick{}}

      iex> create_tick(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tick(attrs \\ %{}) do
    %Tick{}
    |> Tick.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tick.

  ## Examples

      iex> update_tick(tick, %{field: new_value})
      {:ok, %Tick{}}

      iex> update_tick(tick, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tick(%Tick{} = tick, attrs) do
    tick
    |> Tick.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Tick.

  ## Examples

      iex> delete_tick(tick)
      {:ok, %Tick{}}

      iex> delete_tick(tick)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tick(%Tick{} = tick) do
    Repo.delete(tick)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tick changes.

  ## Examples

      iex> change_tick(tick)
      %Ecto.Changeset{source: %Tick{}}

  """
  def change_tick(%Tick{} = tick) do
    Tick.changeset(tick, %{})
  end
end
