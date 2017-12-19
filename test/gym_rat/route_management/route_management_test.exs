defmodule GymRat.RouteManagementTest do
  use GymRat.DataCase

  alias GymRat.RouteManagement

  describe "hold_placements" do
    alias GymRat.RouteManagement.HoldPlacement

    @valid_attrs %{grid_coordinate_x: 42, grid_coordinate_y: 42, hold_id: 42, is_finish: true, is_start: true, route_id: 42}
    @update_attrs %{grid_coordinate_x: 43, grid_coordinate_y: 43, hold_id: 43, is_finish: false, is_start: false, route_id: 43}
    @invalid_attrs %{grid_coordinate_x: nil, grid_coordinate_y: nil, hold_id: nil, is_finish: nil, is_start: nil, route_id: nil}

    def hold_placement_fixture(attrs \\ %{}) do
      {:ok, hold_placement} =
        attrs
        |> Enum.into(@valid_attrs)
        |> RouteManagement.create_hold_placement()

      hold_placement
    end

    test "list_hold_placements/0 returns all hold_placements" do
      hold_placement = hold_placement_fixture()
      assert RouteManagement.list_hold_placements() == [hold_placement]
    end

    test "get_hold_placement!/1 returns the hold_placement with given id" do
      hold_placement = hold_placement_fixture()
      assert RouteManagement.get_hold_placement!(hold_placement.id) == hold_placement
    end

    test "create_hold_placement/1 with valid data creates a hold_placement" do
      assert {:ok, %HoldPlacement{} = hold_placement} = RouteManagement.create_hold_placement(@valid_attrs)
      assert hold_placement.grid_coordinate_x == 42
      assert hold_placement.grid_coordinate_y == 42
      assert hold_placement.hold_id == 42
      assert hold_placement.is_finish == true
      assert hold_placement.is_start == true
      assert hold_placement.route_id == 42
    end

    test "create_hold_placement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RouteManagement.create_hold_placement(@invalid_attrs)
    end

    test "update_hold_placement/2 with valid data updates the hold_placement" do
      hold_placement = hold_placement_fixture()
      assert {:ok, hold_placement} = RouteManagement.update_hold_placement(hold_placement, @update_attrs)
      assert %HoldPlacement{} = hold_placement
      assert hold_placement.grid_coordinate_x == 43
      assert hold_placement.grid_coordinate_y == 43
      assert hold_placement.hold_id == 43
      assert hold_placement.is_finish == false
      assert hold_placement.is_start == false
      assert hold_placement.route_id == 43
    end

    test "update_hold_placement/2 with invalid data returns error changeset" do
      hold_placement = hold_placement_fixture()
      assert {:error, %Ecto.Changeset{}} = RouteManagement.update_hold_placement(hold_placement, @invalid_attrs)
      assert hold_placement == RouteManagement.get_hold_placement!(hold_placement.id)
    end

    test "delete_hold_placement/1 deletes the hold_placement" do
      hold_placement = hold_placement_fixture()
      assert {:ok, %HoldPlacement{}} = RouteManagement.delete_hold_placement(hold_placement)
      assert_raise Ecto.NoResultsError, fn -> RouteManagement.get_hold_placement!(hold_placement.id) end
    end

    test "change_hold_placement/1 returns a hold_placement changeset" do
      hold_placement = hold_placement_fixture()
      assert %Ecto.Changeset{} = RouteManagement.change_hold_placement(hold_placement)
    end
  end

  describe "routes" do
    alias GymRat.RouteManagement.Route

    @valid_attrs %{area_id: 42, color: "some color", expires_on: ~T[14:00:00.000000], grade_id: 42, set_onetime: "some set_onetime", setter_id: 42}
    @update_attrs %{area_id: 43, color: "some updated color", expires_on: ~T[15:01:01.000000], grade_id: 43, set_onetime: "some updated set_onetime", setter_id: 43}
    @invalid_attrs %{area_id: nil, color: nil, expires_on: nil, grade_id: nil, set_onetime: nil, setter_id: nil}

    def route_fixture(attrs \\ %{}) do
      {:ok, route} =
        attrs
        |> Enum.into(@valid_attrs)
        |> RouteManagement.create_route()

      route
    end

    test "list_routes/0 returns all routes" do
      route = route_fixture()
      assert RouteManagement.list_routes() == [route]
    end

    test "get_route!/1 returns the route with given id" do
      route = route_fixture()
      assert RouteManagement.get_route!(route.id) == route
    end

    test "create_route/1 with valid data creates a route" do
      assert {:ok, %Route{} = route} = RouteManagement.create_route(@valid_attrs)
      assert route.area_id == 42
      assert route.color == "some color"
      assert route.expires_on == ~T[14:00:00.000000]
      assert route.grade_id == 42
      assert route.set_onetime == "some set_onetime"
      assert route.setter_id == 42
    end

    test "create_route/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RouteManagement.create_route(@invalid_attrs)
    end

    test "update_route/2 with valid data updates the route" do
      route = route_fixture()
      assert {:ok, route} = RouteManagement.update_route(route, @update_attrs)
      assert %Route{} = route
      assert route.area_id == 43
      assert route.color == "some updated color"
      assert route.expires_on == ~T[15:01:01.000000]
      assert route.grade_id == 43
      assert route.set_onetime == "some updated set_onetime"
      assert route.setter_id == 43
    end

    test "update_route/2 with invalid data returns error changeset" do
      route = route_fixture()
      assert {:error, %Ecto.Changeset{}} = RouteManagement.update_route(route, @invalid_attrs)
      assert route == RouteManagement.get_route!(route.id)
    end

    test "delete_route/1 deletes the route" do
      route = route_fixture()
      assert {:ok, %Route{}} = RouteManagement.delete_route(route)
      assert_raise Ecto.NoResultsError, fn -> RouteManagement.get_route!(route.id) end
    end

    test "change_route/1 returns a route changeset" do
      route = route_fixture()
      assert %Ecto.Changeset{} = RouteManagement.change_route(route)
    end
  end
end