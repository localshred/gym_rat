defmodule GymRat.Inventory do
  @moduledoc """
  The RouteManagement context.
  """

  import Ecto.Query, warn: false
  alias GymRat.Repo

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
end
