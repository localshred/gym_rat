defmodule GymRat.RouteManagementTest do
  use GymRat.DataCase

  alias GymRat.RouteManagement

  describe "areas" do
    alias GymRat.RouteManagement.Area

    @valid_attrs %{gym_id: 42, name: "some name", order: 42}
    @update_attrs %{gym_id: 43, name: "some updated name", order: 43}
    @invalid_attrs %{gym_id: nil, name: nil, order: nil}

    def area_fixture(attrs \\ %{}) do
      {:ok, area} =
        attrs
        |> Enum.into(@valid_attrs)
        |> RouteManagement.create_area()

      area
    end

    test "list_areas/0 returns all areas" do
      area = area_fixture()
      assert RouteManagement.list_areas() == [area]
    end

    test "get_area!/1 returns the area with given id" do
      area = area_fixture()
      assert RouteManagement.get_area!(area.id) == area
    end

    test "create_area/1 with valid data creates a area" do
      assert {:ok, %Area{} = area} = RouteManagement.create_area(@valid_attrs)
      assert area.gym_id == 42
      assert area.name == "some name"
      assert area.order == 42
    end

    test "create_area/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RouteManagement.create_area(@invalid_attrs)
    end

    test "update_area/2 with valid data updates the area" do
      area = area_fixture()
      assert {:ok, area} = RouteManagement.update_area(area, @update_attrs)
      assert %Area{} = area
      assert area.gym_id == 43
      assert area.name == "some updated name"
      assert area.order == 43
    end

    test "update_area/2 with invalid data returns error changeset" do
      area = area_fixture()
      assert {:error, %Ecto.Changeset{}} = RouteManagement.update_area(area, @invalid_attrs)
      assert area == RouteManagement.get_area!(area.id)
    end

    test "delete_area/1 deletes the area" do
      area = area_fixture()
      assert {:ok, %Area{}} = RouteManagement.delete_area(area)
      assert_raise Ecto.NoResultsError, fn -> RouteManagement.get_area!(area.id) end
    end

    test "change_area/1 returns a area changeset" do
      area = area_fixture()
      assert %Ecto.Changeset{} = RouteManagement.change_area(area)
    end
  end

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

  describe "holds" do
    alias GymRat.RouteManagement.Hold

    @valid_attrs %{color: "some color", count: 42, features: "some features", maker: "some maker", material: "some material", primary_use: "some primary_use", size: "some size"}
    @update_attrs %{color: "some updated color", count: 43, features: "some updated features", maker: "some updated maker", material: "some updated material", primary_use: "some updated primary_use", size: "some updated size"}
    @invalid_attrs %{color: nil, count: nil, features: nil, maker: nil, material: nil, primary_use: nil, size: nil}

    def hold_fixture(attrs \\ %{}) do
      {:ok, hold} =
        attrs
        |> Enum.into(@valid_attrs)
        |> RouteManagement.create_hold()

      hold
    end

    test "list_holds/0 returns all holds" do
      hold = hold_fixture()
      assert RouteManagement.list_holds() == [hold]
    end

    test "get_hold!/1 returns the hold with given id" do
      hold = hold_fixture()
      assert RouteManagement.get_hold!(hold.id) == hold
    end

    test "create_hold/1 with valid data creates a hold" do
      assert {:ok, %Hold{} = hold} = RouteManagement.create_hold(@valid_attrs)
      assert hold.color == "some color"
      assert hold.count == 42
      assert hold.features == "some features"
      assert hold.maker == "some maker"
      assert hold.material == "some material"
      assert hold.primary_use == "some primary_use"
      assert hold.size == "some size"
    end

    test "create_hold/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RouteManagement.create_hold(@invalid_attrs)
    end

    test "update_hold/2 with valid data updates the hold" do
      hold = hold_fixture()
      assert {:ok, hold} = RouteManagement.update_hold(hold, @update_attrs)
      assert %Hold{} = hold
      assert hold.color == "some updated color"
      assert hold.count == 43
      assert hold.features == "some updated features"
      assert hold.maker == "some updated maker"
      assert hold.material == "some updated material"
      assert hold.primary_use == "some updated primary_use"
      assert hold.size == "some updated size"
    end

    test "update_hold/2 with invalid data returns error changeset" do
      hold = hold_fixture()
      assert {:error, %Ecto.Changeset{}} = RouteManagement.update_hold(hold, @invalid_attrs)
      assert hold == RouteManagement.get_hold!(hold.id)
    end

    test "delete_hold/1 deletes the hold" do
      hold = hold_fixture()
      assert {:ok, %Hold{}} = RouteManagement.delete_hold(hold)
      assert_raise Ecto.NoResultsError, fn -> RouteManagement.get_hold!(hold.id) end
    end

    test "change_hold/1 returns a hold changeset" do
      hold = hold_fixture()
      assert %Ecto.Changeset{} = RouteManagement.change_hold(hold)
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
