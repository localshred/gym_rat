defmodule GymRatWeb.Graphql.Holds.QueriesTest do
  use GymRatWeb.ConnCase

  import GymRat.TestFactories

  alias GymRat.Inventory
  alias GymRat.Lore

  describe "hold" do
    test "gets a hold by ID" do
      expected_hold = insert(:hold)

      query_name = "getHold"

      query = """
        query #{query_name}($id: ID!) {
          hold(query: { id: $id }) {
            hold {
              id
              maker
              color
              size
              count
              material
              features
              primaryUse
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
          "id" => to_string(expected_hold.id)
        }
      ]
      |> graphql_run()
      |> Lore.path([:data, "hold", "hold"])
      |> assert_hold(expected_hold)
    end

    test "gets a null hold when given ID that doesn't exist in DB" do
      hold_id = -1

      assert Inventory.count_holds() == 0

      query_name = "getHold"

      query = """
        query #{query_name}($id: ID!) {
          hold(query: { id: $id }) {
            hold {
              id
              maker
              color
              size
              count
              material
              features
              primaryUse
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(hold_id)
        }
      ]
      |> graphql_run()
      |> Lore.path([:data, "hold", "hold"])
      |> (fn hold ->
            assert hold == nil
          end).()
    end
  end

  describe "holds" do
    test "gets all holds when no IDs are given" do
      expected_holds =
        insert_list(3, :hold)
        |> Enum.group_by(fn hold -> hold |> Lore.prop(:id) |> to_string() end)

      query_name = "getHolds"

      query = """
        query #{query_name} {
          holds(query: {}) {
            holds {
              id
              maker
              color
              size
              count
              material
              features
              primaryUse
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
      |> Lore.path([:data, "holds", "holds"])
      |> Enum.each(fn actual_hold ->
        expected_hold = List.first(expected_holds[actual_hold["id"]])
        assert_hold(actual_hold, expected_hold)
      end)
    end

    test "gets only holds with given IDs" do
      holds_picked_count = 2
      holds_total_count = 4
      holds = insert_list(holds_total_count, :hold)

      hold_ids =
        holds
        |> Enum.take(holds_picked_count)
        |> Enum.map(Lore.prop(:id))
        |> Enum.map(&to_string/1)

      expected_holds =
        holds
        |> Enum.group_by(fn hold -> hold |> Lore.prop(:id) |> to_string() end)

      query_name = "getHolds"

      query = """
        query #{query_name}(
          $ids: [String!]!
        ){
          holds(query: {
            ids: $ids
          }) {
            holds {
              id
              maker
              color
              size
              count
              material
              features
              primaryUse
              insertedAt
              updatedAt
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{"ids" => hold_ids}
      ]
      |> graphql_run()
      |> Lore.path([:data, "holds", "holds"])
      |> Lore.each(fn actual_hold ->
        expected_hold = List.first(expected_holds[actual_hold["id"]])
        assert_hold(actual_hold, expected_hold)
      end)
      |> (fn holds ->
            assert length(holds) == holds_picked_count
          end).()
    end

    test "retrieves empty list when no holds found for given args" do
      query_name = "getHolds"

      query = """
        query #{query_name} {
          holds(query: {}) {
            holds {
              id
            }
          }
        }
      """

      assert Inventory.count_holds() == 0

      [
        query: query,
        query_name: query_name
      ]
      |> graphql_run()
      |> Lore.path([:data, "holds", "holds"])
      |> (fn holds ->
            assert length(holds) == 0
          end).()
    end
  end

  def assert_hold(actual, expected) do
    assert actual["id"] == to_string(expected.id)
    assert actual["maker"] == expected.maker
    assert actual["color"] == expected.color
    assert actual["size"] == expected.size
    assert actual["count"] == expected.count
    assert actual["material"] == String.upcase(expected.material)
    assert actual["features"] == expected.features
    assert actual["primaryUse"] == String.upcase(expected.primary_use)
    assert_timestamp(actual["insertedAt"], expected.inserted_at)
    assert_timestamp(actual["updatedAt"], expected.updated_at)
  end
end
