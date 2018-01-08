defmodule GymRat.RouteManagement.Context.HoldPlacement do
  @moduledoc """
  The RouteManagement context.
  """

  import Ecto.Query, warn: false
  alias GymRat.Repo

  alias GymRat.RouteManagement.HoldPlacement

  @doc """
  Returns the count of the number of records in the hold_placements table.

  ## Examples

      iex> count_hold_placements()
      42

  """
  def count_hold_placements do
    from(g in "hold_placements")
    |> Repo.aggregate(:count, :id)
  end

  @doc """
  Returns the list of hold_placements.

  ## Examples

      iex> list_hold_placements()
      [%HoldPlacement{}, ...]

  """
  def list_hold_placements do
    Repo.all(HoldPlacement)
  end

  @doc """
  Gets a list of hold_placements by the given IDs.

  ## Examples

      iex> list_hold_placements([123, 456])
      [%HoldPlacement{id: 123}, %HoldPlacement{id: 456}]

      iex> list_hold_placement([])
      []

  """
  def list_hold_placements(ids) when is_list(ids) and length(ids) > 0 do
    HoldPlacement
    |> where([hold_placement], hold_placement.id in ^ids)
    |> Repo.all()
  end

  def list_hold_placements([]) do
    Repo.all(HoldPlacement)
  end

  @doc """
  Gets a single hold_placement or nil if no hold placement exists for the given id.

  ## Examples

      iex> get_hold_placement(123)
      %HoldPlacement{}

      iex> get_hold_placement(456)
      nil

  """
  def get_hold_placement(id), do: Repo.get(HoldPlacement, id)

  @doc """
  Gets a single hold_placement.

  Raises `Ecto.NoResultsError` if the Hold placement does not exist.

  ## Examples

      iex> get_hold_placement!(123)
      %HoldPlacement{}

      iex> get_hold_placement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hold_placement!(id), do: Repo.get!(HoldPlacement, id)

  @doc """
  Creates a hold_placement.

  ## Examples

      iex> create_hold_placement(%{field: value})
      {:ok, %HoldPlacement{}}

      iex> create_hold_placement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hold_placement(attrs \\ %{}) do
    %HoldPlacement{}
    |> HoldPlacement.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hold_placement.

  ## Examples

      iex> update_hold_placement(hold_placement, %{field: new_value})
      {:ok, %HoldPlacement{}}

      iex> update_hold_placement(hold_placement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hold_placement(%HoldPlacement{} = hold_placement, attrs) do
    hold_placement
    |> HoldPlacement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a HoldPlacement.

  ## Examples

      iex> delete_hold_placement(hold_placement)
      {:ok, %HoldPlacement{}}

      iex> delete_hold_placement(hold_placement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hold_placement(%HoldPlacement{} = hold_placement) do
    Repo.delete(hold_placement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hold_placement changes.

  ## Examples

      iex> change_hold_placement(hold_placement)
      %Ecto.Changeset{source: %HoldPlacement{}}

  """
  def change_hold_placement(%HoldPlacement{} = hold_placement) do
    HoldPlacement.changeset(hold_placement, %{})
  end
end
