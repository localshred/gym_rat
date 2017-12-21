defmodule GymRat.RouteManagementTest do
  use GymRat.DataCase

  import GymRat.TestFactories

  alias GymRat.RouteManagement

  describe "hold_placements" do
    alias GymRat.RouteManagement.HoldPlacement

    @update_attrs %{
      grid_coordinate_x: 43,
      grid_coordinate_y: 43,
      hold_id: 43,
      is_finish: false,
      is_start: false,
      route_id: 43
    }
    @invalid_attrs %{
      grid_coordinate_x: nil,
      grid_coordinate_y: nil,
      hold_id: nil,
      is_finish: nil,
      is_start: nil,
      route_id: nil
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
      assert hold_placement.hold_id == expected_hold_placement.hold_id
      assert hold_placement.is_finish == expected_hold_placement.is_finish
      assert hold_placement.is_start == expected_hold_placement.is_start
      assert hold_placement.route_id == expected_hold_placement.route_id
    end

    test "create_hold_placement/1 with valid data creates a hold_placement" do
      expected_hold_placement = params_with_assocs(:hold_placement)
      assert {:ok, %HoldPlacement{} = hold_placement} = RouteManagement.create_hold_placement(expected_hold_placement)
      assert hold_placement.grid_coordinate_x == expected_hold_placement.grid_coordinate_x
      assert hold_placement.grid_coordinate_y == expected_hold_placement.grid_coordinate_y
      assert hold_placement.hold_id == expected_hold_placement.hold_id
      assert hold_placement.is_finish == expected_hold_placement.is_finish
      assert hold_placement.is_start == expected_hold_placement.is_start
      assert hold_placement.route_id == expected_hold_placement.route_id
    end

    test "create_hold_placement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RouteManagement.create_hold_placement(@invalid_attrs)
    end

    test "update_hold_placement/2 with valid data updates the hold_placement" do
      hold = insert(:hold)
      route = insert(:route)
      hold_placement = insert(:hold_placement)
      attributes = %{ @update_attrs |
        hold_id: hold.id,
        route_id: route.id,
      }
      assert {:ok, hold_placement} = RouteManagement.update_hold_placement(hold_placement, attributes)
      assert %HoldPlacement{} = hold_placement
      assert hold_placement.grid_coordinate_x == 43
      assert hold_placement.grid_coordinate_y == 43
      assert hold_placement.hold_id == hold.id
      assert hold_placement.is_finish == false
      assert hold_placement.is_start == false
      assert hold_placement.route_id == route.id
    end

    test "update_hold_placement/2 with invalid data returns error changeset" do
      hold_placement = insert(:hold_placement)
      before_update_hold_placement = RouteManagement.get_hold_placement!(hold_placement.id)
      assert {:error, %Ecto.Changeset{}} = RouteManagement.update_hold_placement(hold_placement, @invalid_attrs)
      assert before_update_hold_placement == RouteManagement.get_hold_placement!(hold_placement.id)
    end

    test "delete_hold_placement/1 deletes the hold_placement" do
      hold_placement = insert(:hold_placement)
      assert {:ok, %HoldPlacement{}} = RouteManagement.delete_hold_placement(hold_placement)
      assert_raise Ecto.NoResultsError, fn -> RouteManagement.get_hold_placement!(hold_placement.id) end
    end

    test "change_hold_placement/1 returns a hold_placement changeset" do
      hold_placement = insert(:hold_placement)
      assert %Ecto.Changeset{} = RouteManagement.change_hold_placement(hold_placement)
    end
  end

  describe "routes" do
    alias GymRat.RouteManagement.Route

    @update_attrs %{
      area_id: 43,
      color: "some updated color",
      expires_on: DateTime.from_unix!(1513802726000, :milliseconds),
      grade_id: 43,
      set_on: DateTime.from_unix!(1515802726000, :milliseconds),
      setter_id: 43
    }
    @invalid_attrs %{
      area_id: nil,
      color: nil,
      expires_on: nil,
      grade_id: nil,
      set_on: nil,
      setter_id: nil
    }

    test "list_routes/0 returns all routes" do
      route = insert(:route)
      expected_route = RouteManagement.get_route!(route.id)
      assert RouteManagement.list_routes() == [expected_route]
    end

    test "get_route!/1 returns the route with given id" do
      route = insert(:route)
      expected_route = RouteManagement.get_route!(route.id)
      assert route.area_id == expected_route.area_id
      assert route.color == expected_route.color
      assert DateTime.to_unix(route.expires_on, :milliseconds) == DateTime.to_unix(expected_route.expires_on, :milliseconds)
      assert route.grade_id == expected_route.grade_id
      assert DateTime.to_unix(route.set_on, :milliseconds) == DateTime.to_unix(expected_route.set_on, :milliseconds)
      assert route.setter_id == expected_route.setter_id
    end

    test "create_route/1 with valid data creates a route" do
      expected_route = params_with_assocs(:route)
      assert {:ok, %Route{} = route} = RouteManagement.create_route(expected_route)
      assert route.area_id == expected_route.area_id
      assert route.color == expected_route.color
      assert route.expires_on == expected_route.expires_on
      assert route.grade_id == expected_route.grade_id
      assert route.set_on == expected_route.set_on
      assert route.setter_id == expected_route.setter_id
    end

    test "create_route/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RouteManagement.create_route(@invalid_attrs)
    end

    test "update_route/2 with valid data updates the route" do
      setter = insert(:user)
      area = insert(:area)
      route = insert(:route)
      attributes = %{ @update_attrs |
        area_id: area.id,
        setter_id: setter.id
      }
      assert {:ok, route} = RouteManagement.update_route(route, attributes)
      assert %Route{} = route
      assert route.area_id == area.id
      assert route.color == "some updated color"
      assert route.expires_on == DateTime.from_unix!(1513802726000, :milliseconds)
      assert route.grade_id == 43
      assert route.set_on == DateTime.from_unix!(1515802726000, :milliseconds)
      assert route.setter_id == setter.id
    end

    test "update_route/2 with invalid data returns error changeset" do
      route = insert(:route)
      route_before_update = RouteManagement.get_route!(route.id)
      assert {:error, %Ecto.Changeset{}} = RouteManagement.update_route(route, @invalid_attrs)
      assert route_before_update == RouteManagement.get_route!(route.id)
    end

    test "delete_route/1 deletes the route" do
      route = insert(:route)
      assert {:ok, %Route{}} = RouteManagement.delete_route(route)
      assert_raise Ecto.NoResultsError, fn -> RouteManagement.get_route!(route.id) end
    end

    test "change_route/1 returns a route changeset" do
      route = insert(:route)
      assert %Ecto.Changeset{} = RouteManagement.change_route(route)
    end
  end
end
