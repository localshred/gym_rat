defmodule GymRat.RouteManagement do
  @moduledoc """
  The RouteManagement context.
  """

  import Ecto.Query, warn: false
  alias GymRat.Repo

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
    |> Repo.all
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
  Gets a list of routes by the given IDs.

  ## Examples

      iex> list_routes([123, 456])
      [%Route{id: 123}, %Route{id: 456}]

      iex> list_route([])
      []

  """
  def list_routes(ids) when is_list(ids) and length(ids) > 0 do
    Route
    |> where([route], route.id in ^ids)
    |> Repo.all
  end

  def list_routes([]) do
    Repo.all(Route)
  end

  @doc """
  Gets a single route or nil if no route exists for the given id.

  ## Examples

      iex> get_route(123)
      %Route{}

      iex> get_route(456)
      nil

  """
  def get_route(id), do: Repo.get(Route, id)

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
