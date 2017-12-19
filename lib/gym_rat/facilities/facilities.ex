defmodule GymRat.Facilities do
  @moduledoc """
  The Facilities context.
  """

  import Ecto.Query, warn: false
  alias GymRat.Repo

  alias GymRat.RouteManagement.Area

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
    |> Repo.all
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

  alias GymRat.Facilities.Gym

  @doc """
  Returns the list of gyms.

  ## Examples

      iex> list_gyms()
      [%Gym{}, ...]

  """
  def list_gyms do
    Repo.all(Gym)
  end

  @doc """
  Gets a list of gyms by the given IDs.

  ## Examples

      iex> list_gyms([123, 456])
      [%Gym{id: 123}, %Gym{id: 456}]

      iex> list_gym([])
      []

  """
  def list_gyms(ids) when is_list(ids) and length(ids) > 0 do
    Gym
    |> where([gym], gym.id in ^ids)
    |> Repo.all
  end

  def list_gyms([]) do
    Repo.all(Gym)
  end

  @doc """
  Gets a single gym by ID or raises an error.

  ## Examples

  iex> get_gym!(123)
  %Gym{}

  iex> get_gym!(456)
   * Ecto.NoResultsError

  """
  def get_gym!(id), do: Repo.get!(Gym, id)

  @doc """
  Gets a single gym by ID or nil if not found.

  ## Examples

      iex> get_gym(123)
      %Gym{}

      iex> get_gym(456)
      nil

  """
  def get_gym(id), do: Repo.get(Gym, id)

  @doc """
  Creates a gym.

  ## Examples

      iex> create_gym(%{field: value})
      {:ok, %Gym{}}

      iex> create_gym(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gym(attrs \\ %{}) do
    %Gym{}
    |> Gym.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gym.

  ## Examples

      iex> update_gym(gym, %{field: new_value})
      {:ok, %Gym{}}

      iex> update_gym(gym, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gym(%Gym{} = gym, attrs) do
    gym
    |> Gym.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Gym.

  ## Examples

      iex> delete_gym(gym)
      {:ok, %Gym{}}

      iex> delete_gym(gym)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gym(%Gym{} = gym) do
    Repo.delete(gym)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gym changes.

  ## Examples

      iex> change_gym(gym)
      %Ecto.Changeset{source: %Gym{}}

  """
  def change_gym(%Gym{} = gym) do
    Gym.changeset(gym, %{})
  end
end
