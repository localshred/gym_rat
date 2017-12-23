defmodule Graphql.Gyms.QueriesTest do
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

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(expected_gym.id)
        }
      ]

      actual_gym = run_options
                   |> graphql_run()
                   |> Lore.path([:data, "gym", "gym"])

      assert actual_gym["id"] == to_string(expected_gym.id)
      assert actual_gym["name"] == expected_gym.name
      assert actual_gym["website"] == expected_gym.website
      assert actual_gym["address"] == expected_gym.address
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
        assert actual_gym["id"] == to_string(expected_gym.id)
        assert actual_gym["name"] == expected_gym.name
        assert actual_gym["website"] == expected_gym.website
        assert actual_gym["address"] == expected_gym.address
      end)
    end
  end

end
