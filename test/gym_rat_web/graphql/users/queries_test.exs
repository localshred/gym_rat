defmodule GymRatWeb.Graphql.Users.QueriesTest do
  use GymRatWeb.ConnCase

  import GymRat.TestFactories

  alias GymRat.Lore
  alias GymRat.Accounts

  describe "user" do
    test "gets a user by ID" do
      expected_user = insert(:user)

      query_name = "userRat"

      query = """
        query #{query_name}($id: ID!) {
          user(query: { id: $id }) {
            user {
              id
              name
              username
              email
              insertedAt
              updatedAt
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(expected_user.id)
        }
      ]
      |> graphql_run()
      |> Lore.path([:data, "user", "user"])
      |> assert_user(expected_user)
    end

    test "gets a null user when given ID that doesn't exist in DB" do
      user_id = -1

      assert Accounts.count_users() == 0

      query_name = "getUser"

      query = """
        query #{query_name}($id: ID!) {
          user(query: { id: $id }) {
            user {
              id
              name
              username
              email
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(user_id)
        }
      ]
      |> graphql_run()
      |> Lore.path([:data, "user", "user"])
      |> (fn user ->
            assert user == nil
          end).()
    end

    test "fetches associated ticks" do
      expected_user = insert(:user)
      insert_list(3, :tick, user: expected_user, number_tries: 3, send_type: "flash")

      query_name = "getUserTicks"

      query = """
        query #{query_name}($id: ID!) {
          user(query: { id: $id }) {
            user {
              id
              ticks {
                id
                number_tries
                send_type
              }
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(expected_user.id)
        }
      ]
      |> graphql_run()
      |> Lore.path([:data, "user", "user"])
      |> (fn %{"id" => user_id, "ticks" => ticks} ->
            assert user_id == to_string(expected_user.id)
            assert ticks != nil
            assert length(ticks) == 3

            Enum.each(ticks, fn tick ->
              assert tick["id"] != nil
              assert tick["number_tries"] == 3
              assert tick["send_type"] == "FLASH"
            end)
          end).()
    end
  end

  describe "users" do
    test "gets all users when no IDs are given" do
      expected_users =
        insert_list(3, :user)
        |> Enum.group_by(fn user -> user |> Lore.prop(:id) |> to_string() end)

      query_name = "getUsers"

      query = """
        query #{query_name} {
          users(query: {}) {
            users {
              id
              name
              username
              email
              insertedAt
              updatedAt
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name
      ]
      |> graphql_run()
      |> Lore.path([:data, "users", "users"])
      |> Enum.each(fn actual_user ->
        expected_user = List.first(expected_users[actual_user["id"]])
        assert_user(actual_user, expected_user)
      end)
    end

    test "gets only users with given IDs" do
      users_picked_count = 2
      users_total_count = 4
      users = insert_list(users_total_count, :user)

      user_ids =
        users
        |> Enum.take(users_picked_count)
        |> Enum.map(Lore.prop(:id))
        |> Enum.map(&to_string/1)

      expected_users =
        users
        |> Enum.group_by(fn user -> user |> Lore.prop(:id) |> to_string() end)

      query_name = "getUsers"

      query = """
        query #{query_name}(
          $ids: [String!]!
        ){
          users(query: {
            ids: $ids
          }) {
            users {
              id
              name
              username
              email
              insertedAt
              updatedAt
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{"ids" => user_ids}
      ]
      |> graphql_run()
      |> Lore.path([:data, "users", "users"])
      |> Lore.each(fn actual_user ->
        expected_user = List.first(expected_users[actual_user["id"]])
        assert_user(actual_user, expected_user)
      end)
      |> (fn users ->
            assert length(users) == users_picked_count
          end).()
    end

    test "retrieves empty list when no users found for given args" do
      query_name = "getUsers"

      query = """
        query #{query_name} {
          users(query: {}) {
            users {
              id
            }
          }
        }
      """

      assert Accounts.count_users() == 0

      [
        query: query,
        query_name: query_name
      ]
      |> graphql_run()
      |> Lore.path([:data, "users", "users"])
      |> (fn users ->
            assert length(users) == 0
          end).()
    end
  end

  def assert_user(actual, expected) do
    assert actual["id"] == to_string(expected.id)
    assert actual["name"] == expected.name
    assert actual["username"] == expected.username
    assert actual["email"] == expected.email
    assert_timestamp(actual["insertedAt"], expected.inserted_at)
    assert_timestamp(actual["updatedAt"], expected.updated_at)
  end
end
