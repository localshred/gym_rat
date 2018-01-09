defmodule GymRat.WallManagement.Context.GridHoldTest do
  use GymRat.DataCase

  import GymRat.TestFactories

  alias GymRat.WallManagement

  describe "grid_holds" do
    alias GymRat.WallManagement.GridHold

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

    test "list_grid_holds/0 returns all grid_holds" do
      grid_hold = insert(:grid_hold)
      expected_grid_hold = WallManagement.get_grid_hold!(grid_hold.id)
      assert WallManagement.list_grid_holds() == [expected_grid_hold]
    end

    test "get_grid_hold!/1 returns the grid_hold with given id" do
      grid_hold = insert(:grid_hold)
      expected_grid_hold = WallManagement.get_grid_hold!(grid_hold.id)
      assert grid_hold.grid_coordinate_x == expected_grid_hold.grid_coordinate_x
      assert grid_hold.grid_coordinate_y == expected_grid_hold.grid_coordinate_y
      assert grid_hold.area_id == expected_grid_hold.area_id
      assert grid_hold.hold_id == expected_grid_hold.hold_id
    end

    test "create_grid_hold/1 with valid data creates a grid_hold" do
      expected_grid_hold = params_with_assocs(:grid_hold)

      assert {:ok, %GridHold{} = grid_hold} =
               WallManagement.create_grid_hold(expected_grid_hold)

      assert grid_hold.grid_coordinate_x == expected_grid_hold.grid_coordinate_x
      assert grid_hold.grid_coordinate_y == expected_grid_hold.grid_coordinate_y
      assert grid_hold.area_id == expected_grid_hold.area_id
      assert grid_hold.hold_id == expected_grid_hold.hold_id
    end

    test "create_grid_hold/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = WallManagement.create_grid_hold(@invalid_attrs)
    end

    test "update_grid_hold/2 with valid data updates the grid_hold" do
      area = insert(:area)
      hold = insert(:hold)
      grid_hold = insert(:grid_hold)
      attributes = %{@update_attrs | area_id: area.id, hold_id: hold.id}

      assert {:ok, grid_hold} =
               WallManagement.update_grid_hold(grid_hold, attributes)

      assert %GridHold{} = grid_hold
      assert grid_hold.grid_coordinate_x == 43
      assert grid_hold.grid_coordinate_y == 43
      assert grid_hold.hold_id == hold.id
      assert grid_hold.area_id == area.id
    end

    test "update_grid_hold/2 with invalid data returns error changeset" do
      grid_hold = insert(:grid_hold)
      before_update_grid_hold = WallManagement.get_grid_hold!(grid_hold.id)

      assert {:error, %Ecto.Changeset{}} =
               WallManagement.update_grid_hold(grid_hold, @invalid_attrs)

      assert before_update_grid_hold ==
               WallManagement.get_grid_hold!(grid_hold.id)
    end

    test "delete_grid_hold/1 deletes the grid_hold" do
      grid_hold = insert(:grid_hold)
      assert {:ok, %GridHold{}} = WallManagement.delete_grid_hold(grid_hold)

      assert_raise Ecto.NoResultsError, fn ->
        WallManagement.get_grid_hold!(grid_hold.id)
      end
    end

    test "change_grid_hold/1 returns a grid_hold changeset" do
      grid_hold = insert(:grid_hold)
      assert %Ecto.Changeset{} = WallManagement.change_grid_hold(grid_hold)
    end
  end
end
