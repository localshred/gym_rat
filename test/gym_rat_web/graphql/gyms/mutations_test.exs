defmodule GymRatWeb.Graphql.Gyms.MutationsTest do
  use GymRatWeb.ConnCase

  import GymRat.TestFactories

  alias GymRat.Lore

  describe "create_gym" do
    test "creates a gym with the given parameters" do
      query_name = "createGym"
      query = """
        mutation #{query_name}(
          $name: String!,
          $website: String!,
          $address: String
        ) {
          createGym(gym: {
            name: $name,
            website: $website,
            address: $address
          }) {
            gym {
              id
              name
              website
              address
            }
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "name" => "My Test Gym",
          "website" => "http://mygym.com",
          "address" => "some address"
        }
      ]

      before_count = GymRat.Facilities.count_gyms()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "createGym", "gym"])
      |> assert_gym(run_options[:variables])

      after_count = GymRat.Facilities.count_gyms()
      assert before_count + 1 == after_count
    end
  end

  describe "delete_gym" do
    test "deletes a gym by ID" do
      gym = insert(:gym)
      query_name = "deleteGym"
      query = """
        mutation #{query_name}(
          $id: ID!
        ) {
          deleteGym(query: { id: $id }) {
            success
            deletedCount
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{ "id" => to_string(gym.id) }
      ]

      before_count = GymRat.Facilities.count_gyms()

      delete_result = run_options
                      |> graphql_run()
                      |> Lore.path([:data, "deleteGym"])

      assert delete_result["success"] == true
      assert delete_result["deletedCount"] == 1

      after_count = GymRat.Facilities.count_gyms()
      assert before_count - 1 == after_count
    end

    test "returns false success and 0 deletedCount when given gym ID doesn't exist" do
      gym_id = -1

      assert GymRat.Facilities.count_gyms() == 0

      query_name = "deleteGym"
      query = """
        mutation #{query_name}(
          $id: ID!
        ) {
          deleteGym(query: { id: $id }) {
            success
            deletedCount
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{ "id" => to_string(gym_id) }
      ]

      delete_result = run_options
                      |> graphql_run()
                      |> Lore.path([:data, "deleteGym"])

      assert delete_result["success"] == false
      assert delete_result["deletedCount"] == 0
      assert GymRat.Facilities.count_gyms() == 0
    end
  end

  def assert_gym(actual, expected) do
    assert actual["id"] != nil
    assert actual["name"] == expected["name"]
    assert actual["website"] == expected["website"]
    assert actual["address"] == expected["address"]
  end
end
