defmodule GymRatWeb.Graphql.GridHolds.QueriesTest do
  use GymRatWeb.ConnCase

  import GymRat.TestFactories

  alias GymRat.WallManagement
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

  describe "grid_hold" do
    test "gets a grid_hold by ID" do
      expected_grid_hold = insert(:grid_hold)

      query_name = "getGridHold"

      query = """
        query #{query_name}($id: ID!) {
          grid_hold(query: { id: $id }) {
            grid_hold {
              #{@fields}
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(expected_grid_hold.id)
        }
      ]
      |> graphql_run()
      |> Lore.path([:data, "grid_hold", "grid_hold"])
      |> assert_grid_hold(expected_grid_hold)
    end

    test "gets a null grid_hold when given ID that doesn't exist in DB" do
      grid_hold_id = -1

      assert WallManagement.count_grid_holds() == 0

      query_name = "getGridHold"

      query = """
        query #{query_name}($id: ID!) {
          grid_hold(query: { id: $id }) {
            grid_hold {
              #{@fields}
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(grid_hold_id)
        }
      ]
      |> graphql_run()
      |> Lore.path([:data, "grid_hold", "grid_hold"])
      |> (fn grid_hold ->
            assert grid_hold == nil
          end).()
    end
  end

  describe "grid_holds" do
    test "gets all grid_holds when no IDs are given" do
      expected_grid_holds =
        insert_list(3, :grid_hold)
        |> Enum.group_by(fn grid_hold -> grid_hold |> Lore.prop(:id) |> to_string() end)

      query_name = "getGridHolds"

      query = """
        query #{query_name} {
          grid_holds(query: {}) {
            grid_holds {
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
      |> Lore.path([:data, "grid_holds", "grid_holds"])
      |> Enum.each(fn actual_grid_hold ->
        expected_grid_hold = List.first(expected_grid_holds[actual_grid_hold["id"]])
        assert_grid_hold(actual_grid_hold, expected_grid_hold)
      end)
    end

    test "gets only grid_holds with given IDs" do
      grid_holds_picked_count = 2
      grid_holds_total_count = 4
      grid_holds = insert_list(grid_holds_total_count, :grid_hold)

      grid_hold_ids =
        grid_holds
        |> Enum.take(grid_holds_picked_count)
        |> Enum.map(Lore.prop(:id))
        |> Enum.map(&to_string/1)

      expected_grid_holds =
        grid_holds
        |> Enum.group_by(fn grid_hold -> grid_hold |> Lore.prop(:id) |> to_string() end)

      query_name = "getGridHolds"

      query = """
        query #{query_name}(
          $ids: [String!]!
        ){
          grid_holds(query: {
            ids: $ids
          }) {
            grid_holds {
              #{@fields}
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{"ids" => grid_hold_ids}
      ]
      |> graphql_run()
      |> Lore.path([:data, "grid_holds", "grid_holds"])
      |> Lore.each(fn actual_grid_hold ->
        expected_grid_hold = List.first(expected_grid_holds[actual_grid_hold["id"]])
        assert_grid_hold(actual_grid_hold, expected_grid_hold)
      end)
      |> (fn grid_holds ->
            assert length(grid_holds) == grid_holds_picked_count
          end).()
    end

    test "retrieves empty list when no grid_holds found for given args" do
      query_name = "getGridHolds"

      query = """
        query #{query_name} {
          grid_holds(query: {}) {
            grid_holds {
              id
            }
          }
        }
      """

      assert WallManagement.count_grid_holds() == 0

      [
        query: query,
        query_name: query_name
      ]
      |> graphql_run()
      |> Lore.path([:data, "grid_holds", "grid_holds"])
      |> (fn grid_holds ->
            assert length(grid_holds) == 0
          end).()
    end
  end

  def assert_grid_hold(actual, expected) do
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
