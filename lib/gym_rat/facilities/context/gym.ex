defmodule GymRat.Facilities.Context.Gym do
  @moduledoc """
  The Facilities.Gym sub-context.
  """

  import Ecto.Query, warn: false
  alias GymRat.Repo

  alias GymRat.Facilities.Gym

  @doc """
  Returns the count of the number of records in the gyms table.

  ## Examples

      iex> count_gyms()
      42

  """
  def count_gyms do
    from(g in "gyms")
    |> Repo.aggregate(:count, :id)
  end

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
    |> Repo.all()
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
