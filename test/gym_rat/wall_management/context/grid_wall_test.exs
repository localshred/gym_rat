defmodule GymRat.WallManagement.Context.GridWallTest do
  use GymRat.DataCase

  import GymRat.TestFactories

  alias GymRat.WallManagement

  describe "grid_walls" do
    alias GymRat.WallManagement.GridWall

    @update_attrs %{
      angle: 30.0,
      area_id: nil,
      last_reset_at: from_unix(1_515_802_726_000),
      name: "The old 30",
      x_width: 66,
      y_height: 18
    }
    @invalid_attrs %{
      angle: nil,
      area_id: nil,
      last_reset_at: nil,
      name: nil,
      x_width: nil,
      y_height: nil
    }

    test "list_grid_walls/0 returns all grid_walls" do
      grid_wall = insert(:grid_wall)
      expected_grid_wall = WallManagement.get_grid_wall!(grid_wall.id)
      assert WallManagement.list_grid_walls() == [expected_grid_wall]
    end

    test "get_grid_wall!/1 returns the grid_wall with given id" do
      grid_wall = insert(:grid_wall)
      expected_grid_wall = WallManagement.get_grid_wall!(grid_wall.id)
      assert grid_wall.angle == expected_grid_wall.angle
      assert grid_wall.name == expected_grid_wall.name
      assert DateTime.diff(grid_wall.last_reset_at, expected_grid_wall.last_reset_at, :milliseconds) == 0
      assert grid_wall.x_width == expected_grid_wall.x_width
      assert grid_wall.y_height == expected_grid_wall.y_height
      assert grid_wall.area_id == expected_grid_wall.area_id
    end

    test "create_grid_wall/1 with valid data creates a grid_wall" do
      expected_grid_wall = params_with_assocs(:grid_wall)

      assert {:ok, %GridWall{} = grid_wall} =
               WallManagement.create_grid_wall(expected_grid_wall)

      assert grid_wall.angle == expected_grid_wall.angle
      assert grid_wall.name == expected_grid_wall.name
      assert DateTime.diff(grid_wall.last_reset_at, expected_grid_wall.last_reset_at, :milliseconds) == 0
      assert grid_wall.x_width == expected_grid_wall.x_width
      assert grid_wall.y_height == expected_grid_wall.y_height
      assert grid_wall.area_id == expected_grid_wall.area_id
    end

    test "create_grid_wall/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = WallManagement.create_grid_wall(@invalid_attrs)
    end

    test "update_grid_wall/2 with valid data updates the grid_wall" do
      area = insert(:area)
      grid_wall = insert(:grid_wall)
      attributes = %{@update_attrs | area_id: area.id}

      assert {:ok, grid_wall} =
               WallManagement.update_grid_wall(grid_wall, attributes)

      assert %GridWall{} = grid_wall
      assert grid_wall.angle == 30
      assert grid_wall.name == "The old 30"
      assert DateTime.diff(grid_wall.last_reset_at, from_unix(1_515_802_726_000), :milliseconds) == 0
      assert grid_wall.x_width == 66
      assert grid_wall.y_height == 18
      assert grid_wall.area_id == area.id
    end

    test "update_grid_wall/2 with invalid data returns error changeset" do
      grid_wall = insert(:grid_wall)
      before_update_grid_wall = WallManagement.get_grid_wall!(grid_wall.id)

      assert {:error, %Ecto.Changeset{}} =
               WallManagement.update_grid_wall(grid_wall, @invalid_attrs)

      assert before_update_grid_wall ==
               WallManagement.get_grid_wall!(grid_wall.id)
    end

    test "delete_grid_wall/1 deletes the grid_wall" do
      grid_wall = insert(:grid_wall)
      assert {:ok, %GridWall{}} = WallManagement.delete_grid_wall(grid_wall)

      assert_raise Ecto.NoResultsError, fn ->
        WallManagement.get_grid_wall!(grid_wall.id)
      end
    end

    test "change_grid_wall/1 returns a grid_wall changeset" do
      grid_wall = insert(:grid_wall)
      assert %Ecto.Changeset{} = WallManagement.change_grid_wall(grid_wall)
    end
  end
end
