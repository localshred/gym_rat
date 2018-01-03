defmodule GymRat.Facilities.Context.Area do
  @moduledoc """
  The Facilities.Area sub-context.
  """

  import Ecto.Query, warn: false

  alias GymRat.Facilities.Area
  alias GymRat.Lore
  alias GymRat.Repo

  @doc """
  Returns the count of the number of records in the areas table.

  ## Examples

      iex> count_areas()
      42

  """
  def count_areas do
    from(g in "areas")
    |> Repo.aggregate(:count, :id)
  end

  @doc """
  Returns the list of areas.

  ## Examples

      iex> list_areas()
      [%Area{}, ...]

  """
  def list_areas do
    Repo.all(Area)
  end

  @doc """
  Gets a list of areas by the given IDs.

  ## Examples

      iex> list_areas([123, 456])
      [%Area{id: 123}, %Area{id: 456}]

      iex> list_area([])
      []

  """
  def list_areas(ids) when is_list(ids) and length(ids) > 0 do
    Area
    |> where([area], area.id in ^ids)
    |> Repo.all()
  end

  def list_areas([]) do
    Repo.all(Area)
  end

  @doc """
  Gets a single area or nil if no area exists for that id.

  ## Examples

      iex> get_area(123)
      %Area{}

      iex> get_area(456)
      nil

  """
  def get_area(id), do: Repo.get(Area, id)

  @doc """
  Gets a single area.

  Raises `Ecto.NoResultsError` if the Area does not exist.

  ## Examples

      iex> get_area!(123)
      %Area{}

      iex> get_area!(456)
      ** (Ecto.NoResultsError)

  """
  def get_area!(id), do: Repo.get!(Area, id)

  @doc """
  Creates a area.

  ## Examples

      iex> create_area(%{field: value})
      {:ok, %Area{}}

      iex> create_area(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_area(attrs \\ %{}) do
    %Area{}
    |> Area.changeset(attrs)
    |> Repo.insert()
    |> refetch_with_associations()
  end

  @doc """
  Updates a area.

  ## Examples

      iex> update_area(area, %{field: new_value})
      {:ok, %Area{}}

      iex> update_area(area, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_area(%Area{} = area, attrs) do
    area
    |> Area.changeset(attrs)
    |> Repo.update()
    |> refetch_with_associations()
  end

  @doc """
  Deletes a Area.

  ## Examples

      iex> delete_area(area)
      {:ok, %Area{}}

      iex> delete_area(area)
      {:error, %Ecto.Changeset{}}

  """
  def delete_area(%Area{} = area) do
    Repo.delete(area)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking area changes.

  ## Examples

      iex> change_area(area)
      %Ecto.Changeset{source: %Area{}}

  """
  def change_area(%Area{} = area) do
    Area.changeset(area, %{})
  end

  defp refetch_with_associations({:ok, %Area{id: id}}) do
    id
    |> get_area!()
    |> Lore.ok()
  end

  defp refetch_with_associations({:error, _changeset} = error_tuple) do
    error_tuple
  end
end
