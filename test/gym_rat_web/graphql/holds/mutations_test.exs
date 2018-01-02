defmodule GymRatWeb.Graphql.Holds.MutationsTest do
  use GymRatWeb.ConnCase

  import GymRat.TestFactories

  alias GymRat.Inventory
  alias GymRat.Lore

  describe "create_hold" do
    test "creates a hold with the given parameters" do
      query_name = "createHold"

      query = """
        mutation #{query_name}(
          $maker: String!,
          $color: String!,
          $size: String!,
          $count: Int!,
          $material: Material!,
          $features: String!,
          $primaryUse: HoldType!
        ) {
          createHold(hold: {
            maker: $maker,
            color: $color,
            size: $size,
            count: $count,
            material: $material,
            features: $features,
            primaryUse: $primaryUse,
          }) {
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

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "maker" => "tension",
          "color" => "brown",
          "size" => "XL",
          "count" => 42,
          "material" => "WOOD",
          "features" => "slopey",
          "primaryUse" => "HANDHOLD"
        }
      ]

      before_count = Inventory.count_holds()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "createHold", "hold"])
      |> assert_hold(run_options[:variables])

      after_count = Inventory.count_holds()
      assert before_count + 1 == after_count
    end

    test "does not require a hold difficulty" do
      query_name = "createHold"

      query = """
        mutation #{query_name}(
          $maker: String!,
          $color: String!,
          $size: String!,
          $count: Int!,
          $material: Material!,
          $features: String!,
          $primaryUse: HoldType!
        ) {
          createHold(hold: {
            maker: $maker,
            color: $color,
            size: $size,
            count: $count,
            material: $material,
            features: $features,
            primaryUse: $primaryUse,
          }) {
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

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "maker" => "tension",
          "color" => "brown",
          "size" => "XL",
          "count" => 42,
          "material" => "WOOD",
          "features" => "slopey",
          "primaryUse" => "HANDHOLD"
        }
      ]

      before_count = Inventory.count_holds()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "createHold", "hold"])
      |> assert_hold(run_options[:variables])

      after_count = Inventory.count_holds()
      assert before_count + 1 == after_count
    end
  end

  describe "delete_hold" do
    test "deletes a hold by ID" do
      hold = insert(:hold)
      query_name = "deleteHold"

      query = """
        mutation #{query_name}(
          $id: ID!
        ) {
          deleteHold(query: { id: $id }) {
            success
            deletedCount
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{"id" => to_string(hold.id)}
      ]

      before_count = Inventory.count_holds()

      delete_result =
        run_options
        |> graphql_run()
        |> Lore.path([:data, "deleteHold"])

      assert delete_result["success"] == true
      assert delete_result["deletedCount"] == 1

      after_count = Inventory.count_holds()
      assert before_count - 1 == after_count
    end

    test "returns false success and 0 deletedCount when given hold ID doesn't exist" do
      hold_id = -1

      assert Inventory.count_holds() == 0

      query_name = "deleteHold"

      query = """
        mutation #{query_name}(
          $id: ID!
        ) {
          deleteHold(query: { id: $id }) {
            success
            deletedCount
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{"id" => to_string(hold_id)}
      ]

      delete_result =
        run_options
        |> graphql_run()
        |> Lore.path([:data, "deleteHold"])

      assert delete_result["success"] == false
      assert delete_result["deletedCount"] == 0
      assert Inventory.count_holds() == 0
    end
  end

  describe "update_hold" do
    test "updates an existing hold with the given parameters" do
      existing_hold = insert(:hold)
      query_name = "updateHold"

      query = """
        mutation #{query_name}(
          $id: ID!,
          $maker: String!,
          $color: String!,
          $size: String!,
          $count: Int!,
          $material: Material!,
          $features: String!,
          $primaryUse: HoldType!
        ) {
          updateHold(query: { id: $id }, hold: {
            maker: $maker,
            color: $color,
            size: $size,
            count: $count,
            material: $material,
            features: $features,
            primaryUse: $primaryUse,
          }) {
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

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(existing_hold.id),
          "maker" => "tension",
          "color" => "brown",
          "size" => "XL",
          "count" => 42,
          "material" => "WOOD",
          "features" => "slopey",
          "primaryUse" => "HANDHOLD"
        }
      ]

      before_count = Inventory.count_holds()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "updateHold", "hold"])
      |> assert_hold(run_options[:variables])

      after_count = Inventory.count_holds()
      assert before_count == after_count
    end

    test "returns null when the hold doesn't exist with the given ID" do
      hold_id = -1

      assert Inventory.count_holds() == 0

      query_name = "updateHold"

      query = """
        mutation #{query_name}(
          $id: ID!,
          $maker: String!,
          $color: String!,
          $size: String!,
          $count: Int!,
          $material: Material!,
          $features: String!,
          $primaryUse: HoldType!
        ) {
          updateHold(query: { id: $id }, hold: {
            maker: $maker,
            color: $color,
            size: $size,
            count: $count,
            material: $material,
            features: $features,
            primaryUse: $primaryUse,
          }) {
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

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(hold_id),
          "maker" => "tension",
          "color" => "brown",
          "size" => "XL",
          "count" => 42,
          "material" => "WOOD",
          "features" => "slopey",
          "primaryUse" => "HANDHOLD"
        }
      ]

      run_options
      |> graphql_run(:expect_errors)
      |> assert_contains_error("Unable to update hold")

      assert Inventory.count_holds() == 0
    end
  end

  def assert_hold(actual, expected) do
    assert actual["id"] != nil
    assert actual["maker"] == expected["maker"]
    assert actual["color"] == expected["color"]
    assert actual["size"] == expected["size"]
    assert actual["count"] == expected["count"]
    assert actual["material"] == String.upcase(expected["material"])
    assert actual["features"] == expected["features"]
    assert actual["primaryUse"] == String.upcase(expected["primaryUse"])
    actual
  end
end
