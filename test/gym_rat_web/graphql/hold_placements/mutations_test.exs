defmodule GymRatWeb.Graphql.HoldPlacements.MutationsTest do
  use GymRatWeb.ConnCase

  import GymRat.TestFactories

  alias GymRat.Inventory
  alias GymRat.Lore
  alias GymRat.RouteManagement

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
  """

  describe "create_hold_placement" do
    test "creates a hold_placement with the given parameters" do
      area = insert(:area)
      hold = insert(:hold)
      query_name = "createHoldPlacement"

      query = """
        mutation #{query_name}(
          $areaId: ID!,
          $hold: CreateHoldInput!,
          $x: Float!,
          $y: Float!
        ) {
          createHoldPlacement(hold_placement: {
            areaId: $areaId,
            hold: $hold,
            gridCoordinate: {
              x: $x,
              y: $y
            }
          }) {
            hold_placement {
              #{@fields}
            }
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "areaId" => to_string(area.id),
          "hold" => hold_input(hold),
          "x" => 32.5,
          "y" => 45.0
        }
      ]

      before_count = RouteManagement.count_hold_placements()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "createHoldPlacement", "hold_placement"])
      |> assert_hold_placement(run_options[:variables], area, hold)

      after_count = RouteManagement.count_hold_placements()
      assert before_count + 1 == after_count
    end

    test "creates a new hold since the associated hold is not in the DB" do
      area = insert(:area)
      hold = build(:hold)
      query_name = "createHoldPlacement"

      query = """
        mutation #{query_name}(
          $areaId: ID!,
          $hold: CreateHoldInput!,
          $x: Float!,
          $y: Float!
        ) {
          createHoldPlacement(hold_placement: {
            areaId: $areaId,
            hold: $hold,
            gridCoordinate: {
              x: $x,
              y: $y
            }
          }) {
            hold_placement {
              #{@fields}
            }
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "areaId" => to_string(area.id),
          "hold" => hold_input(hold),
          "x" => 32.5,
          "y" => 45.0
        }
      ]

      before_count = Inventory.count_holds()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "createHoldPlacement", "hold_placement"])
      |> assert_hold_placement(run_options[:variables], area, hold)

      after_count = Inventory.count_holds()
      assert before_count + 1 == after_count
    end

    test "uses the existing hold that matches the given hold params" do
      area = insert(:area)
      hold = insert(:hold)
      query_name = "createHoldPlacement"

      query = """
        mutation #{query_name}(
          $areaId: ID!,
          $hold: CreateHoldInput!,
          $x: Float!,
          $y: Float!
        ) {
          createHoldPlacement(hold_placement: {
            areaId: $areaId,
            hold: $hold,
            gridCoordinate: {
              x: $x,
              y: $y
            }
          }) {
            hold_placement {
              #{@fields}
            }
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "areaId" => to_string(area.id),
          "hold" => hold_input(hold),
          "x" => 32.5,
          "y" => 45.0
        }
      ]

      before_count = Inventory.count_holds()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "createHoldPlacement", "hold_placement"])
      |> assert_hold_placement(run_options[:variables], area, hold)

      after_count = Inventory.count_holds()
      assert before_count == after_count
    end
  end

  describe "delete_hold_placement" do
    test "deletes a hold_placement by ID" do
      hold_placement = insert(:hold_placement)
      query_name = "deleteHoldPlacement"

      query = """
        mutation #{query_name}(
          $id: ID!
        ) {
          deleteHoldPlacement(query: { id: $id }) {
            success
            deletedCount
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{"id" => to_string(hold_placement.id)}
      ]

      before_count = RouteManagement.count_hold_placements()

      delete_result =
        run_options
        |> graphql_run()
        |> Lore.path([:data, "deleteHoldPlacement"])

      assert delete_result["success"] == true
      assert delete_result["deletedCount"] == 1

      after_count = RouteManagement.count_hold_placements()
      assert before_count - 1 == after_count
    end

    test "returns false success and 0 deletedCount when given hold_placement ID doesn't exist" do
      hold_placement_id = -1

      assert RouteManagement.count_hold_placements() == 0

      query_name = "deleteHoldPlacement"

      query = """
        mutation #{query_name}(
          $id: ID!
        ) {
          deleteHoldPlacement(query: { id: $id }) {
            success
            deletedCount
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{"id" => to_string(hold_placement_id)}
      ]

      delete_result =
        run_options
        |> graphql_run()
        |> Lore.path([:data, "deleteHoldPlacement"])

      assert delete_result["success"] == false
      assert delete_result["deletedCount"] == 0
      assert RouteManagement.count_hold_placements() == 0
    end
  end

  describe "update_hold_placement" do
    test "updates an existing hold_placement with the given parameters" do
      area = insert(:area)
      hold = insert(:hold)
      existing_hold_placement = insert(:hold_placement)
      query_name = "updateHoldPlacement"

      query = """
        mutation #{query_name}(
          $id: ID!,
          $areaId: ID!,
          $holdId: ID!,
          $x: Float!,
          $y: Float!
        ) {
          updateHoldPlacement(
            query: { id: $id },
            hold_placement: {
              areaId: $areaId,
              holdId: $holdId,
              gridCoordinate: {
                x: $x,
                y: $y
              }
            }
          ) {
            hold_placement {
              #{@fields}
            }
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(existing_hold_placement.id),
          "areaId" => to_string(area.id),
          "holdId" => to_string(hold.id),
          "x" => 32.5,
          "y" => 45.0
        }
      ]

      before_count = RouteManagement.count_hold_placements()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "updateHoldPlacement", "hold_placement"])
      |> assert_hold_placement(run_options[:variables], area, hold)

      after_count = RouteManagement.count_hold_placements()
      assert before_count == after_count
    end

    test "returns null when the hold_placement doesn't exist with the given ID" do
      hold_placement_id = -1

      assert RouteManagement.count_hold_placements() == 0

      query_name = "updateHoldPlacement"

      query = """
        mutation #{query_name}(
          $id: ID!,
          $x: Float!
          $y: Float!
        ) {
          updateHoldPlacement(
            query: { id: $id },
            hold_placement: {
              gridCoordinate: { x: $x, y: $y }
            }
          ) {
            hold_placement {
              #{@fields}
            }
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(hold_placement_id),
          "x" => 32.5,
          "y" => 45.0
        }
      ]

      run_options
      |> graphql_run(:expect_errors)
      |> assert_contains_error("Unable to update hold placement")

      assert RouteManagement.count_hold_placements() == 0
    end
  end

  def assert_hold_placement(actual, expected, area, hold) do
    assert actual["id"] != nil
    assert actual["area"]["id"] == to_string(area.id)
    assert actual["area"]["name"] == area.name
    if hold.id do
      assert actual["hold"]["id"] == to_string(hold.id)
    end
    assert actual["hold"]["maker"] == hold.maker
    assert actual["gridCoordinate"]["x"] == expected["x"]
    assert actual["gridCoordinate"]["y"] == expected["y"]
    actual
  end

  def hold_input(hold) do
    %{
      "maker" => hold.maker,
      "color" => hold.color,
      "size" => hold.size,
      "count" => hold.count,
      "material" => String.upcase(hold.material),
      "features" => hold.features,
      "primaryUse" => String.upcase(hold.primary_use)
    }
  end
end
