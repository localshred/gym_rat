defmodule GymRat.RouteManagement.Context.RouteTest do
  use GymRat.DataCase

  import GymRat.TestFactories

  alias GymRat.RouteManagement

  describe "routes" do
    alias GymRat.RouteManagement.Route

    @update_attrs %{
      area_id: nil,
      color: "some updated color",
      expires_on: from_unix(1_513_802_726_000),
      grade_id: nil,
      set_on: from_unix(1_515_802_726_000),
      setter_id: nil
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
      assert to_unix(route.expires_on) == to_unix(expected_route.expires_on)
      assert route.grade_id == expected_route.grade_id
      assert to_unix(route.set_on) == to_unix(expected_route.set_on)
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
      grade = insert(:grade)
      setter = insert(:user)
      area = insert(:area)
      route = insert(:route)
      attributes = %{@update_attrs | area_id: area.id, grade_id: grade.id, setter_id: setter.id}
      assert {:ok, route} = RouteManagement.update_route(route, attributes)
      assert %Route{} = route
      assert route.area_id == area.id
      assert route.color == "some updated color"
      assert route.expires_on == from_unix(1_513_802_726_000)
      assert route.grade_id == grade.id
      assert route.set_on == from_unix(1_515_802_726_000)
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
