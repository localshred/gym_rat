defmodule GymRat.Accounts do
  @moduledoc """
  The Accounts context.
  """

  alias GymRat.Accounts.Context.User
  defdelegate count_users, to: User
  defdelegate change_user(user), to: User
  defdelegate create_user(attrs), to: User
  defdelegate delete_user(user), to: User
  defdelegate get_user!(id), to: User
  defdelegate get_user(id), to: User
  defdelegate list_users(ids), to: User
  defdelegate list_users, to: User
  defdelegate update_user(user, attrs), to: User
end
