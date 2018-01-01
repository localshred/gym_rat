defmodule GymRatWeb.Graphql.Users.MutationsTest do
  use GymRatWeb.ConnCase

  import GymRat.TestFactories

  alias GymRat.Accounts
  alias GymRat.Lore

  describe "create_user" do
    test "creates a user with the given parameters" do
      query_name = "createUser"

      query = """
        mutation #{query_name}(
          $name: String!,
          $username: String!,
          $email: String
        ) {
          createUser(user: {
            name: $name,
            username: $username,
            email: $email
          }) {
            user {
              id
              name
              username
              email
            }
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "name" => "My Test User",
          "username" => "testuser",
          "email" => "test@test.com"
        }
      ]

      before_count = Accounts.count_users()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "createUser", "user"])
      |> assert_user(run_options[:variables])

      after_count = Accounts.count_users()
      assert before_count + 1 == after_count
    end
  end

  describe "delete_user" do
    test "deletes a user by ID" do
      user = insert(:user)
      query_name = "deleteUser"

      query = """
        mutation #{query_name}(
          $id: ID!
        ) {
          deleteUser(query: { id: $id }) {
            success
            deletedCount
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{"id" => to_string(user.id)}
      ]

      before_count = Accounts.count_users()

      delete_result =
        run_options
        |> graphql_run()
        |> Lore.path([:data, "deleteUser"])

      assert delete_result["success"] == true
      assert delete_result["deletedCount"] == 1

      after_count = Accounts.count_users()
      assert before_count - 1 == after_count
    end

    test "returns false success and 0 deletedCount when given user ID doesn't exist" do
      user_id = -1

      assert Accounts.count_users() == 0

      query_name = "deleteUser"

      query = """
        mutation #{query_name}(
          $id: ID!
        ) {
          deleteUser(query: { id: $id }) {
            success
            deletedCount
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{"id" => to_string(user_id)}
      ]

      delete_result =
        run_options
        |> graphql_run()
        |> Lore.path([:data, "deleteUser"])

      assert delete_result["success"] == false
      assert delete_result["deletedCount"] == 0
      assert Accounts.count_users() == 0
    end
  end

  describe "update_user" do
    test "updates an existing user with the given parameters" do
      existing_user = insert(:user)
      query_name = "updateUser"

      query = """
        mutation #{query_name}(
          $id: ID!,
          $name: String!,
          $username: String!,
          $email: String
        ) {
          updateUser(query: { id: $id }, user: {
            name: $name,
            username: $username,
            email: $email
          }) {
            user {
              id
              name
              username
              email
            }
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(existing_user.id),
          "name" => "My Test User",
          "username" => "testuser",
          "email" => "test@test.com"
        }
      ]

      before_count = Accounts.count_users()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "updateUser", "user"])
      |> assert_user(run_options[:variables])

      after_count = Accounts.count_users()
      assert before_count == after_count
    end

    test "returns null when the user doesn't exist with the given ID" do
      user_id = -1

      assert Accounts.count_users() == 0

      query_name = "updateUser"

      query = """
        mutation #{query_name}(
          $id: ID!,
          $name: String!,
          $username: String!,
          $email: String
        ) {
          updateUser(query: { id: $id }, user: {
            name: $name,
            username: $username,
            email: $email
          }) {
            user {
              id
              name
              username
              email
            }
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(user_id),
          "name" => "My Test User",
          "username" => "testuser",
          "email" => "test@test.com"
        }
      ]

      run_options
      |> graphql_run(:expect_errors)
      |> assert_contains_error("Unable to update user")

      assert Accounts.count_users() == 0
    end
  end

  def assert_user(actual, expected) do
    assert actual["id"] != nil
    assert actual["name"] == expected["name"]
    assert actual["username"] == expected["username"]
    assert actual["email"] == expected["email"]
  end
end
