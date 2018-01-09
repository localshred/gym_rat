defmodule GymRat.WallManagement.Context.GridHold do
  @moduledoc """
  The WallManagement context.
  """

  import Ecto.Query, warn: false
  alias GymRat.Repo

  alias GymRat.WallManagement.GridHold

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking grid_hold changes.

  ## Examples

      iex> change_grid_hold(grid_hold)
      %Ecto.Changeset{source: %GridHold{}}

  """
  def change_grid_hold(%GridHold{} = grid_hold) do
    GridHold.changeset(grid_hold, %{})
  end

  @doc """
  Returns the count of the number of records in the grid_holds table.

  ## Examples

      iex> count_grid_holds()
      42

  """
  def count_grid_holds do
    from(g in "grid_holds")
    |> Repo.aggregate(:count, :id)
  end

  @doc """
  Creates a grid_hold.

  ## Examples

      iex> create_grid_hold(%{field: value})
      {:ok, %GridHold{}}

      iex> create_grid_hold(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_grid_hold(attrs \\ %{}) do
    %GridHold{}
    |> GridHold.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a GridHold.

  ## Examples

      iex> delete_grid_hold(grid_hold)
      {:ok, %GridHold{}}

      iex> delete_grid_hold(grid_hold)
      {:error, %Ecto.Changeset{}}

  """
  def delete_grid_hold(%GridHold{} = grid_hold) do
    Repo.delete(grid_hold)
  end

  @doc """
  Gets a single grid_hold or nil if no grid hold exists for the given id.

  ## Examples

      iex> get_grid_hold(123)
      %GridHold{}

      iex> get_grid_hold(456)
      nil

  """
  def get_grid_hold(id), do: Repo.get(GridHold, id)

  @doc """
  Gets a single grid_hold.

  Raises `Ecto.NoResultsError` if the grid hold does not exist.

  ## Examples

      iex> get_grid_hold!(123)
      %GridHold{}

      iex> get_grid_hold!(456)
      ** (Ecto.NoResultsError)

  """
  def get_grid_hold!(id), do: Repo.get!(GridHold, id)

  @doc """
  Returns the list of grid_holds.

  ## Examples

      iex> list_grid_holds()
      [%GridHold{}, ...]

  """
  def list_grid_holds do
    Repo.all(GridHold)
  end

  @doc """
  Gets a list of grid_holds by the given IDs.

  ## Examples

      iex> list_grid_holds([123, 456])
      [%GridHold{id: 123}, %GridHold{id: 456}]

      iex> list_grid_hold([])
      []

  """
  def list_grid_holds(ids) when is_list(ids) and length(ids) > 0 do
    GridHold
    |> where([grid_hold], grid_hold.id in ^ids)
    |> Repo.all()
  end

  def list_grid_holds([]) do
    Repo.all(GridHold)
  end

  @doc """
  Updates a grid_hold.

  ## Examples

      iex> update_grid_hold(grid_hold, %{field: new_value})
      {:ok, %GridHold{}}

      iex> update_grid_hold(grid_hold, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_grid_hold(%GridHold{} = grid_hold, attrs) do
    grid_hold
    |> GridHold.changeset(attrs)
    |> Repo.update()
  end
end
