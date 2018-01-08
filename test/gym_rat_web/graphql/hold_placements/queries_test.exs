defmodule GymRatWeb.Graphql.HoldPlacements.QueriesTest do
  use GymRatWeb.ConnCase

  import GymRat.TestFactories

  alias GymRat.RouteManagement
  alias GymRat.Lore

  @fields """
  id
  area {
    id
    name
  }
  hold {
    id
    maker
  }
  gridCoordinate {
    x
    y
  }
  insertedAt
  updatedAt
  """

  describe "hold_placement" do
    test "gets a hold_placement by ID" do
      expected_hold_placement = insert(:hold_placement)

      query_name = "getHoldPlacement"

      query = """
        query #{query_name}($id: ID!) {
          hold_placement(query: { id: $id }) {
            hold_placement {
              #{@fields}
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(expected_hold_placement.id)
        }
      ]
      |> graphql_run()
      |> Lore.path([:data, "hold_placement", "hold_placement"])
      |> assert_hold_placement(expected_hold_placement)
    end

    test "gets a null hold_placement when given ID that doesn't exist in DB" do
      hold_placement_id = -1

      assert RouteManagement.count_hold_placements() == 0

      query_name = "getHoldPlacement"

      query = """
        query #{query_name}($id: ID!) {
          hold_placement(query: { id: $id }) {
            hold_placement {
              #{@fields}
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(hold_placement_id)
        }
      ]
      |> graphql_run()
      |> Lore.path([:data, "hold_placement", "hold_placement"])
      |> (fn hold_placement ->
            assert hold_placement == nil
          end).()
    end
  end

  describe "hold_placements" do
    test "gets all hold_placements when no IDs are given" do
      expected_hold_placements =
        insert_list(3, :hold_placement)
        |> Enum.group_by(fn hold_placement -> hold_placement |> Lore.prop(:id) |> to_string() end)

      query_name = "getHoldPlacements"

      query = """
        query #{query_name} {
          hold_placements(query: {}) {
            hold_placements {
              #{@fields}
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name
      ]
      |> graphql_run()
      |> Lore.path([:data, "hold_placements", "hold_placements"])
      |> Enum.each(fn actual_hold_placement ->
        expected_hold_placement = List.first(expected_hold_placements[actual_hold_placement["id"]])
        assert_hold_placement(actual_hold_placement, expected_hold_placement)
      end)
    end

    test "gets only hold_placements with given IDs" do
      hold_placements_picked_count = 2
      hold_placements_total_count = 4
      hold_placements = insert_list(hold_placements_total_count, :hold_placement)

      hold_placement_ids =
        hold_placements
        |> Enum.take(hold_placements_picked_count)
        |> Enum.map(Lore.prop(:id))
        |> Enum.map(&to_string/1)

      expected_hold_placements =
        hold_placements
        |> Enum.group_by(fn hold_placement -> hold_placement |> Lore.prop(:id) |> to_string() end)

      query_name = "getHoldPlacements"

      query = """
        query #{query_name}(
          $ids: [String!]!
        ){
          hold_placements(query: {
            ids: $ids
          }) {
            hold_placements {
              #{@fields}
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{"ids" => hold_placement_ids}
      ]
      |> graphql_run()
      |> Lore.path([:data, "hold_placements", "hold_placements"])
      |> Lore.each(fn actual_hold_placement ->
        expected_hold_placement = List.first(expected_hold_placements[actual_hold_placement["id"]])
        assert_hold_placement(actual_hold_placement, expected_hold_placement)
      end)
      |> (fn hold_placements ->
            assert length(hold_placements) == hold_placements_picked_count
          end).()
    end

    test "retrieves empty list when no hold_placements found for given args" do
      query_name = "getHoldPlacements"

      query = """
        query #{query_name} {
          hold_placements(query: {}) {
            hold_placements {
              id
            }
          }
        }
      """

      assert RouteManagement.count_hold_placements() == 0

      [
        query: query,
        query_name: query_name
      ]
      |> graphql_run()
      |> Lore.path([:data, "hold_placements", "hold_placements"])
      |> (fn hold_placements ->
            assert length(hold_placements) == 0
          end).()
    end
  end

  def assert_hold_placement(actual, expected) do
    assert actual["id"] == to_string(expected.id)
    assert actual["area"]["id"] == to_string(expected.area.id)
    assert actual["area"]["name"] == expected.area.name
    assert actual["hold"]["id"] == to_string(expected.hold.id)
    assert actual["hold"]["maker"] == expected.hold.maker
    assert actual["gridCoordinate"]["x"] == expected.grid_coordinate_x
    assert actual["gridCoordinate"]["y"] == expected.grid_coordinate_y
    assert_timestamp(actual["insertedAt"], expected.inserted_at)
    assert_timestamp(actual["updatedAt"], expected.updated_at)
  end
end
