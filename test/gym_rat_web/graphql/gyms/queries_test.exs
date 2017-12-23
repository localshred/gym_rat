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

      actual_gym = graphql_run(run_options)
                   |> Lore.path([:data, "gym", "gym"])
      assert actual_gym["id"] == to_string(expected_gym.id)
      assert actual_gym["name"] == expected_gym.name
      assert actual_gym["website"] == expected_gym.website
      assert actual_gym["address"] == expected_gym.address
    end
  end

end
