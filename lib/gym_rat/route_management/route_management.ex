defmodule GymRat.RouteManagement do
  @moduledoc """
  The RouteManagement context.
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

  alias GymRat.RouteManagement.HoldPlacement

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

  alias GymRat.RouteManagement.Hold

  @doc """
  Returns the list of holds.

  ## Examples

      iex> list_holds()
      [%Hold{}, ...]

  """
  def list_holds do
    Repo.all(Hold)
  end

  @doc """
  Gets a single hold.

  Raises `Ecto.NoResultsError` if the Hold does not exist.

  ## Examples

      iex> get_hold!(123)
      %Hold{}

      iex> get_hold!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hold!(id), do: Repo.get!(Hold, id)

  @doc """
  Creates a hold.

  ## Examples

      iex> create_hold(%{field: value})
      {:ok, %Hold{}}

      iex> create_hold(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hold(attrs \\ %{}) do
    %Hold{}
    |> Hold.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hold.

  ## Examples

      iex> update_hold(hold, %{field: new_value})
      {:ok, %Hold{}}

      iex> update_hold(hold, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hold(%Hold{} = hold, attrs) do
    hold
    |> Hold.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Hold.

  ## Examples

      iex> delete_hold(hold)
      {:ok, %Hold{}}

      iex> delete_hold(hold)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hold(%Hold{} = hold) do
    Repo.delete(hold)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hold changes.

  ## Examples

      iex> change_hold(hold)
      %Ecto.Changeset{source: %Hold{}}

  """
  def change_hold(%Hold{} = hold) do
    Hold.changeset(hold, %{})
  end

  alias GymRat.RouteManagement.Route

  @doc """
  Returns the list of routes.

  ## Examples

      iex> list_routes()
      [%Route{}, ...]

  """
  def list_routes do
    Repo.all(Route)
  end

  @doc """
  Gets a single route.

  Raises `Ecto.NoResultsError` if the Route does not exist.

  ## Examples

      iex> get_route!(123)
      %Route{}

      iex> get_route!(456)
      ** (Ecto.NoResultsError)

  """
  def get_route!(id), do: Repo.get!(Route, id)

  @doc """
  Creates a route.

  ## Examples

      iex> create_route(%{field: value})
      {:ok, %Route{}}

      iex> create_route(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_route(attrs \\ %{}) do
    %Route{}
    |> Route.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a route.

  ## Examples

      iex> update_route(route, %{field: new_value})
      {:ok, %Route{}}

      iex> update_route(route, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_route(%Route{} = route, attrs) do
    route
    |> Route.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Route.

  ## Examples

      iex> delete_route(route)
      {:ok, %Route{}}

      iex> delete_route(route)
      {:error, %Ecto.Changeset{}}

  """
  def delete_route(%Route{} = route) do
    Repo.delete(route)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking route changes.

  ## Examples

      iex> change_route(route)
      %Ecto.Changeset{source: %Route{}}

  """
  def change_route(%Route{} = route) do
    Route.changeset(route, %{})
  end
end
