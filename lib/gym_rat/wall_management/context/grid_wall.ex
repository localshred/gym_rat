defmodule GymRat.WallManagement.Context.GridWall do
  @moduledoc """
  The WallManagement context.
  """

  import Ecto.Query, warn: false
  alias GymRat.Repo

  alias GymRat.Lore
  alias GymRat.WallManagement.GridWall

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking grid_wall changes.

  ## Examples

      iex> change_grid_wall(grid_wall)
      %Ecto.Changeset{source: %GridWall{}}

  """
  def change_grid_wall(%GridWall{} = grid_wall) do
    GridWall.changeset(grid_wall, %{})
  end

  @doc """
  Returns the count of the number of records in the grid_walls table.

  ## Examples

      iex> count_grid_walls()
      42

  """
  def count_grid_walls do
    from(g in "grid_walls")
    |> Repo.aggregate(:count, :id)
  end

  @doc """
  Creates a grid_wall.

  ## Examples

      iex> create_grid_wall(%{field: value})
      {:ok, %GridWall{}}

      iex> create_grid_wall(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_grid_wall(attrs \\ %{}) do
    %GridWall{}
    |> GridWall.changeset(attrs)
    |> Repo.insert()
    |> refetch_with_associations()
  end

  @doc """
  Deletes a GridWall.

  ## Examples

      iex> delete_grid_wall(grid_wall)
      {:ok, %GridWall{}}

      iex> delete_grid_wall(grid_wall)
      {:error, %Ecto.Changeset{}}

  """
  def delete_grid_wall(%GridWall{} = grid_wall) do
    Repo.delete(grid_wall)
  end

  @doc """
  Gets a single grid_wall or nil if no grid hold exists for the given id.

  ## Examples

      iex> get_grid_wall(123)
      %GridWall{}

      iex> get_grid_wall(456)
      nil

  """
  def get_grid_wall(id) do
    GridWall
    |> preload([:area])
    |> Repo.get(id)
  end

  @doc """
  Gets a single grid_wall.

  Raises `Ecto.NoResultsError` if the grid hold does not exist.

  ## Examples

      iex> get_grid_wall!(123)
      %GridWall{}

      iex> get_grid_wall!(456)
      ** (Ecto.NoResultsError)

  """
  def get_grid_wall!(id) do
    GridWall
    |> preload([:area])
    |> Repo.get!(id)
  end

  @doc """
  Returns the list of grid_walls.

  ## Examples

      iex> list_grid_walls()
      [%GridWall{}, ...]

  """
  def list_grid_walls do
    GridWall
    |> preload([:area])
    |> Repo.all()
  end

  @doc """
  Gets a list of grid_walls by the given IDs.

  ## Examples

      iex> list_grid_walls([123, 456])
      [%GridWall{id: 123}, %GridWall{id: 456}]

      iex> list_grid_wall([])
      []

  """
  def list_grid_walls(ids) when is_list(ids) and length(ids) > 0 do
    GridWall
    |> where([grid_wall], grid_wall.id in ^ids)
    |> preload([:area])
    |> Repo.all()
  end

  def list_grid_walls([]) do
    list_grid_walls()
  end

  @doc """
  Updates a grid_wall.

  ## Examples

      iex> update_grid_wall(grid_wall, %{field: new_value})
      {:ok, %GridWall{}}

      iex> update_grid_wall(grid_wall, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_grid_wall(%GridWall{} = grid_wall, attrs) do
    grid_wall
    |> GridWall.changeset(attrs)
    |> Repo.update()
    |> refetch_with_associations()
  end

  defp refetch_with_associations({:ok, %GridWall{id: id}}) do
    id
    |> get_grid_wall!()
    |> Lore.ok()
  end

  defp refetch_with_associations({:error, _changeset} = error_tuple) do
    error_tuple
  end
end
