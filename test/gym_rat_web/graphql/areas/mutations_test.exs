defmodule GymRatWeb.Graphql.Areas.MutationsTest do
  use GymRatWeb.ConnCase

  import GymRat.TestFactories

  alias GymRat.Facilities
  alias GymRat.Lore

  describe "create_area" do
    test "creates a area with the given parameters" do
      gym = insert(:gym)
      query_name = "createArea"

      query = """
        mutation #{query_name}(
          $gymId: Int!,
          $name: String!,
          $order: Int!
        ) {
          createArea(area: {
            gymId: $gymId,
            name: $name,
            order: $order
          }) {
            area {
              id
              name
              order
              gym {
                id
                name
              }
            }
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "gymId" => to_string(gym.id),
          "name" => "My Test Area",
          "order" => 3
        }
      ]

      before_count = Facilities.count_areas()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "createArea", "area"])
      |> assert_area(run_options[:variables], gym)

      after_count = Facilities.count_areas()
      assert before_count + 1 == after_count
    end
  end

  describe "delete_area" do
    test "deletes a area by ID" do
      area = insert(:area)
      query_name = "deleteArea"

      query = """
        mutation #{query_name}(
          $id: ID!
        ) {
          deleteArea(query: { id: $id }) {
            success
            deletedCount
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{"id" => to_string(area.id)}
      ]

      before_count = Facilities.count_areas()

      delete_result =
        run_options
        |> graphql_run()
        |> Lore.path([:data, "deleteArea"])

      assert delete_result["success"] == true
      assert delete_result["deletedCount"] == 1

      after_count = Facilities.count_areas()
      assert before_count - 1 == after_count
    end

    test "returns false success and 0 deletedCount when given area ID doesn't exist" do
      area_id = -1

      assert Facilities.count_areas() == 0

      query_name = "deleteArea"

      query = """
        mutation #{query_name}(
          $id: ID!
        ) {
          deleteArea(query: { id: $id }) {
            success
            deletedCount
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{"id" => to_string(area_id)}
      ]

      delete_result =
        run_options
        |> graphql_run()
        |> Lore.path([:data, "deleteArea"])

      assert delete_result["success"] == false
      assert delete_result["deletedCount"] == 0
      assert Facilities.count_areas() == 0
    end
  end

  describe "update_area" do
    test "updates an existing area with the given parameters" do
      existing_area = insert(:area)
      query_name = "updateArea"

      query = """
        mutation #{query_name}(
          $id: ID!,
          $name: String!,
          $order: Int!
        ) {
          updateArea(query: { id: $id }, area: {
            name: $name,
            order: $order
          }) {
            area {
              id
              name
              order
            }
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(existing_area.id),
          "name" => "My Test Area",
          "order" => 5
        }
      ]

      before_count = Facilities.count_areas()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "updateArea", "area"])
      |> assert_area(run_options[:variables])

      after_count = Facilities.count_areas()
      assert before_count == after_count
    end

    test "returns null when the area doesn't exist with the given ID" do
      area_id = -1

      assert Facilities.count_areas() == 0

      query_name = "updateArea"

      query = """
        mutation #{query_name}(
          $id: ID!,
          $name: String!,
          $order: Int!
        ) {
          updateArea(query: { id: $id }, area: {
            name: $name,
            order: $order
          }) {
            area {
              id
              name
              order
            }
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(area_id),
          "name" => "My Test Gym",
          "order" => 7
        }
      ]

      run_options
      |> graphql_run(:expect_errors)
      |> assert_contains_error("Unable to update area")

      assert Facilities.count_areas() == 0
    end
  end

  def assert_area(actual, expected, gym \\ nil) do
    assert actual["id"] != nil
    assert actual["name"] == expected["name"]
    assert actual["order"] == expected["order"]

    if gym do
      assert actual["gym"]["id"] == to_string(gym.id)
      assert actual["gym"]["name"] == gym.name
    end
  end
end
