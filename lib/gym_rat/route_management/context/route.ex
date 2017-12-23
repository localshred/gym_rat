defmodule GymRat.RouteManagement.Context.Route do
  @moduledoc """
  The RouteManagement context.
  """

  import Ecto.Query, warn: false
  alias GymRat.Repo

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
    |> Repo.all()
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
