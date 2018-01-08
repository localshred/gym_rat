defmodule GymRat.RouteManagement.Context.HoldPlacementTest do
  use GymRat.DataCase

  import GymRat.TestFactories

  alias GymRat.RouteManagement

  describe "hold_placements" do
    alias GymRat.RouteManagement.HoldPlacement

    @update_attrs %{
      area_id: nil,
      grid_coordinate_x: 43.0,
      grid_coordinate_y: 43.0,
      hold_id: nil
    }
    @invalid_attrs %{
      area_id: nil,
      grid_coordinate_x: nil,
      grid_coordinate_y: nil,
      hold_id: nil
    }

    test "list_hold_placements/0 returns all hold_placements" do
      hold_placement = insert(:hold_placement)
      expected_hold_placement = RouteManagement.get_hold_placement!(hold_placement.id)
      assert RouteManagement.list_hold_placements() == [expected_hold_placement]
    end

    test "get_hold_placement!/1 returns the hold_placement with given id" do
      hold_placement = insert(:hold_placement)
      expected_hold_placement = RouteManagement.get_hold_placement!(hold_placement.id)
      assert hold_placement.grid_coordinate_x == expected_hold_placement.grid_coordinate_x
      assert hold_placement.grid_coordinate_y == expected_hold_placement.grid_coordinate_y
      assert hold_placement.area_id == expected_hold_placement.area_id
      assert hold_placement.hold_id == expected_hold_placement.hold_id
    end

    test "create_hold_placement/1 with valid data creates a hold_placement" do
      expected_hold_placement = params_with_assocs(:hold_placement)

      assert {:ok, %HoldPlacement{} = hold_placement} =
               RouteManagement.create_hold_placement(expected_hold_placement)

      assert hold_placement.grid_coordinate_x == expected_hold_placement.grid_coordinate_x
      assert hold_placement.grid_coordinate_y == expected_hold_placement.grid_coordinate_y
      assert hold_placement.area_id == expected_hold_placement.area_id
      assert hold_placement.hold_id == expected_hold_placement.hold_id
    end

    test "create_hold_placement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RouteManagement.create_hold_placement(@invalid_attrs)
    end

    test "update_hold_placement/2 with valid data updates the hold_placement" do
      area = insert(:area)
      hold = insert(:hold)
      hold_placement = insert(:hold_placement)
      attributes = %{@update_attrs | area_id: area.id, hold_id: hold.id}

      assert {:ok, hold_placement} =
               RouteManagement.update_hold_placement(hold_placement, attributes)

      assert %HoldPlacement{} = hold_placement
      assert hold_placement.grid_coordinate_x == 43
      assert hold_placement.grid_coordinate_y == 43
      assert hold_placement.hold_id == hold.id
      assert hold_placement.area_id == area.id
    end

    test "update_hold_placement/2 with invalid data returns error changeset" do
      hold_placement = insert(:hold_placement)
      before_update_hold_placement = RouteManagement.get_hold_placement!(hold_placement.id)

      assert {:error, %Ecto.Changeset{}} =
               RouteManagement.update_hold_placement(hold_placement, @invalid_attrs)

      assert before_update_hold_placement ==
               RouteManagement.get_hold_placement!(hold_placement.id)
    end

    test "delete_hold_placement/1 deletes the hold_placement" do
      hold_placement = insert(:hold_placement)
      assert {:ok, %HoldPlacement{}} = RouteManagement.delete_hold_placement(hold_placement)

      assert_raise Ecto.NoResultsError, fn ->
        RouteManagement.get_hold_placement!(hold_placement.id)
      end
    end

    test "change_hold_placement/1 returns a hold_placement changeset" do
      hold_placement = insert(:hold_placement)
      assert %Ecto.Changeset{} = RouteManagement.change_hold_placement(hold_placement)
    end
  end
end
