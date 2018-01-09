defmodule GymRatWeb.Graphql.GridHolds.MutationsTest do
  use GymRatWeb.ConnCase

  import GymRat.TestFactories

  alias GymRat.Inventory
  alias GymRat.Lore
  alias GymRat.WallManagement

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

  describe "create_grid_hold" do
    test "creates a grid_hold with the given parameters" do
      area = insert(:area)
      hold = insert(:hold)
      query_name = "createGridHold"

      query = """
        mutation #{query_name}(
          $areaId: ID!,
          $hold: CreateHoldInput!,
          $x: Float!,
          $y: Float!
        ) {
          createGridHold(grid_hold: {
            areaId: $areaId,
            hold: $hold,
            gridCoordinate: {
              x: $x,
              y: $y
            }
          }) {
            grid_hold {
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

      before_count = WallManagement.count_grid_holds()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "createGridHold", "grid_hold"])
      |> assert_grid_hold(run_options[:variables], area, hold)

      after_count = WallManagement.count_grid_holds()
      assert before_count + 1 == after_count
    end

    test "creates a new hold since the associated hold is not in the DB" do
      area = insert(:area)
      hold = build(:hold)
      query_name = "createGridHold"

      query = """
        mutation #{query_name}(
          $areaId: ID!,
          $hold: CreateHoldInput!,
          $x: Float!,
          $y: Float!
        ) {
          createGridHold(grid_hold: {
            areaId: $areaId,
            hold: $hold,
            gridCoordinate: {
              x: $x,
              y: $y
            }
          }) {
            grid_hold {
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
      |> Lore.path([:data, "createGridHold", "grid_hold"])
      |> assert_grid_hold(run_options[:variables], area, hold)

      after_count = Inventory.count_holds()
      assert before_count + 1 == after_count
    end

    test "uses the existing hold that matches the given hold params" do
      area = insert(:area)
      hold = insert(:hold)
      query_name = "createGridHold"

      query = """
        mutation #{query_name}(
          $areaId: ID!,
          $hold: CreateHoldInput!,
          $x: Float!,
          $y: Float!
        ) {
          createGridHold(grid_hold: {
            areaId: $areaId,
            hold: $hold,
            gridCoordinate: {
              x: $x,
              y: $y
            }
          }) {
            grid_hold {
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
      |> Lore.path([:data, "createGridHold", "grid_hold"])
      |> assert_grid_hold(run_options[:variables], area, hold)

      after_count = Inventory.count_holds()
      assert before_count == after_count
    end
  end

  describe "delete_grid_hold" do
    test "deletes a grid_hold by ID" do
      grid_hold = insert(:grid_hold)
      query_name = "deleteGridHold"

      query = """
        mutation #{query_name}(
          $id: ID!
        ) {
          deleteGridHold(query: { id: $id }) {
            success
            deletedCount
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{"id" => to_string(grid_hold.id)}
      ]

      before_count = WallManagement.count_grid_holds()

      delete_result =
        run_options
        |> graphql_run()
        |> Lore.path([:data, "deleteGridHold"])

      assert delete_result["success"] == true
      assert delete_result["deletedCount"] == 1

      after_count = WallManagement.count_grid_holds()
      assert before_count - 1 == after_count
    end

    test "returns false success and 0 deletedCount when given grid_hold ID doesn't exist" do
      grid_hold_id = -1

      assert WallManagement.count_grid_holds() == 0

      query_name = "deleteGridHold"

      query = """
        mutation #{query_name}(
          $id: ID!
        ) {
          deleteGridHold(query: { id: $id }) {
            success
            deletedCount
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{"id" => to_string(grid_hold_id)}
      ]

      delete_result =
        run_options
        |> graphql_run()
        |> Lore.path([:data, "deleteGridHold"])

      assert delete_result["success"] == false
      assert delete_result["deletedCount"] == 0
      assert WallManagement.count_grid_holds() == 0
    end
  end

  describe "update_grid_hold" do
    test "updates an existing grid_hold with the given parameters" do
      area = insert(:area)
      hold = insert(:hold)
      existing_grid_hold = insert(:grid_hold)
      query_name = "updateGridHold"

      query = """
        mutation #{query_name}(
          $id: ID!,
          $areaId: ID!,
          $holdId: ID!,
          $x: Float!,
          $y: Float!
        ) {
          updateGridHold(
            query: { id: $id },
            grid_hold: {
              areaId: $areaId,
              holdId: $holdId,
              gridCoordinate: {
                x: $x,
                y: $y
              }
            }
          ) {
            grid_hold {
              #{@fields}
            }
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(existing_grid_hold.id),
          "areaId" => to_string(area.id),
          "holdId" => to_string(hold.id),
          "x" => 32.5,
          "y" => 45.0
        }
      ]

      before_count = WallManagement.count_grid_holds()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "updateGridHold", "grid_hold"])
      |> assert_grid_hold(run_options[:variables], area, hold)

      after_count = WallManagement.count_grid_holds()
      assert before_count == after_count
    end

    test "returns null when the grid_hold doesn't exist with the given ID" do
      grid_hold_id = -1

      assert WallManagement.count_grid_holds() == 0

      query_name = "updateGridHold"

      query = """
        mutation #{query_name}(
          $id: ID!,
          $x: Float!
          $y: Float!
        ) {
          updateGridHold(
            query: { id: $id },
            grid_hold: {
              gridCoordinate: { x: $x, y: $y }
            }
          ) {
            grid_hold {
              #{@fields}
            }
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(grid_hold_id),
          "x" => 32.5,
          "y" => 45.0
        }
      ]

      run_options
      |> graphql_run(:expect_errors)
      |> assert_contains_error("Unable to update grid hold")

      assert WallManagement.count_grid_holds() == 0
    end
  end

  def assert_grid_hold(actual, expected, area, hold) do
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
