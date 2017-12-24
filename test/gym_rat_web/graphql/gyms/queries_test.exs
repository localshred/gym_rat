defmodule GymRatWeb.Graphql.Gyms.QueriesTest do
  use GymRatWeb.ConnCase

  import GymRat.TestFactories

  alias GymRat.Lore

  describe "gym" do
    test "gets a gym by ID" do
      expected_gym = insert(:gym)

      query_name = "gymRat"
      query = """
        query #{query_name}($id: ID!) {
          gym(query: { id: $id }) {
            gym {
              id
              name
              website
              address
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(expected_gym.id)
        }
      ]
      |> graphql_run()
      |> Lore.path([:data, "gym", "gym"])
      |> assert_gym(expected_gym)
    end
  end

  describe "gyms" do
    test "gets all gyms when no IDs are given" do
      expected_gyms = insert_list(3, :gym)
                      |> Enum.group_by(fn gym -> gym |> Lore.prop(:id) |> to_string() end)

      query_name = "getGyms"
      query = """
        query #{query_name} {
          gyms(query: {}) {
            gyms {
              id
              name
              website
              address
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name
      ]
      |> graphql_run()
      |> Lore.path([:data, "gyms", "gyms"])
      |> Enum.each(fn actual_gym ->
        expected_gym = List.first(expected_gyms[actual_gym["id"]])
        assert_gym(actual_gym, expected_gym)
      end)
    end

    test "gets only gyms with given IDs" do
      gyms_picked_count = 2
      gyms_total_count = 4
      gyms = insert_list(gyms_total_count, :gym)
      gym_ids = gyms
                |> Enum.take(gyms_picked_count)
                |> Enum.map(Lore.prop(:id))
                |> Enum.map(&to_string/1)

      expected_gyms = gyms
                      |> Enum.group_by(fn gym -> gym |> Lore.prop(:id) |> to_string() end)

      query_name = "getGyms"
      query = """
        query #{query_name}(
          $ids: [String!]!
        ){
          gyms(query: {
            ids: $ids
          }) {
            gyms {
              id
              name
              website
              address
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{ "ids" => gym_ids }
      ]
      |> graphql_run()
      |> Lore.path([:data, "gyms", "gyms"])
      |> Lore.each(fn actual_gym ->
        expected_gym = List.first(expected_gyms[actual_gym["id"]])
        assert_gym(actual_gym, expected_gym)
      end)
      |> (fn gyms ->
        assert length(gyms) == gyms_picked_count
      end).()
    end

    test "retrieves empty list when no gyms found for given args" do
      query_name = "getGyms"
      query = """
        query #{query_name} {
          gyms(query: {}) {
            gyms {
              id
              name
              website
              address
            }
          }
        }
      """

      assert GymRat.Facilities.count_gyms() == 0

      [
        query: query,
        query_name: query_name
      ]
      |> graphql_run()
      |> Lore.path([:data, "gyms", "gyms"])
      |> (fn gyms ->
        assert length(gyms) == 0
      end).()
    end
  end

  def assert_gym(actual, expected) do
    assert actual["id"] == to_string(expected.id)
    assert actual["name"] == expected.name
    assert actual["website"] == expected.website
    assert actual["address"] == expected.address
  end
end
