defmodule GymRatWeb.Graphql.Gyms.MutationsTest do
  use GymRatWeb.ConnCase

  # import GymRat.TestFactories

  alias GymRat.Lore

  describe "create_gym" do
    test "gets a gym by ID" do
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

  def assert_gym(actual, expected) do
    assert actual["id"] != nil
    assert actual["name"] == expected["name"]
    assert actual["website"] == expected["website"]
    assert actual["address"] == expected["address"]
  end
end
