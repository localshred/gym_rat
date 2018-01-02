defmodule GymRatWeb.Graphql.Routes.QueriesTest do
  use GymRatWeb.ConnCase

  import GymRat.TestFactories

  alias GymRat.RouteManagement
  alias GymRat.Lore

  @route_fields """
  id
  area {
    id
    name
  }
  setter {
    id
    name
  }
  name
  color
  grades {
    initialGrade {
      id
      system
      major
      minor
    }
  }
  ticks {
    id
    numberTries
  }
  setOn
  expiresOn
  insertedAt
  updatedAt
  """

  describe "route" do
    test "gets a route by ID" do
      expected_route = insert(:route)

      query_name = "getRoute"

      query = """
        query #{query_name}($id: ID!) {
          route(query: { id: $id }) {
            route {
              #{@route_fields}
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(expected_route.id)
        }
      ]
      |> graphql_run()
      |> Lore.path([:data, "route", "route"])
      |> assert_route(expected_route)
    end

    test "gets a null route when given ID that doesn't exist in DB" do
      route_id = -1

      assert RouteManagement.count_routes() == 0

      query_name = "getRoute"

      query = """
        query #{query_name}($id: ID!) {
          route(query: { id: $id }) {
            route {
              id
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(route_id)
        }
      ]
      |> graphql_run()
      |> Lore.path([:data, "route", "route"])
      |> (fn route ->
            assert route == nil
          end).()
    end
  end

  describe "routes" do
    test "gets all routes when no IDs are given" do
      expected_routes =
        insert_list(3, :route)
        |> Enum.group_by(fn route -> route |> Lore.prop(:id) |> to_string() end)

      query_name = "getRoutes"

      query = """
        query #{query_name} {
          routes(query: {}) {
            routes {
              #{@route_fields}
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name
      ]
      |> graphql_run()
      |> Lore.path([:data, "routes", "routes"])
      |> Enum.each(fn actual_route ->
        expected_route = List.first(expected_routes[actual_route["id"]])
        assert_route(actual_route, expected_route)
      end)
    end

    test "gets only routes with given IDs" do
      routes_picked_count = 2
      routes_total_count = 4
      routes = insert_list(routes_total_count, :route)

      route_ids =
        routes
        |> Enum.take(routes_picked_count)
        |> Enum.map(Lore.prop(:id))
        |> Enum.map(&to_string/1)

      expected_routes =
        routes
        |> Enum.group_by(fn route -> route |> Lore.prop(:id) |> to_string() end)

      query_name = "getRoutes"

      query = """
        query #{query_name}(
          $ids: [String!]!
        ){
          routes(query: {
            ids: $ids
          }) {
            routes {
              #{@route_fields}
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{"ids" => route_ids}
      ]
      |> graphql_run()
      |> Lore.path([:data, "routes", "routes"])
      |> Lore.each(fn actual_route ->
        expected_route = List.first(expected_routes[actual_route["id"]])
        assert_route(actual_route, expected_route)
      end)
      |> (fn routes ->
            assert length(routes) == routes_picked_count
          end).()
    end

    test "retrieves empty list when no routes found for given args" do
      query_name = "getRoutes"

      query = """
        query #{query_name} {
          routes(query: {}) {
            routes {
              id
            }
          }
        }
      """

      assert RouteManagement.count_routes() == 0

      [
        query: query,
        query_name: query_name
      ]
      |> graphql_run()
      |> Lore.path([:data, "routes", "routes"])
      |> (fn routes ->
            assert length(routes) == 0
          end).()
    end
  end

  def assert_route(actual, expected) do
    assert actual["id"] == to_string(expected.id)
    assert actual["name"] == expected.name
    assert actual["color"] == expected.color
    assert_timestamp(actual["setOn"], expected.set_on)
    assert_timestamp(actual["expiresOn"], expected.expires_on)
    assert actual["area"]["id"] == to_string(expected.area.id)
    assert actual["area"]["name"] == expected.area.name
    assert actual["setter"]["id"] == to_string(expected.setter.id)
    assert actual["setter"]["name"] == expected.setter.name
    assert actual["grades"]["initialGrade"]["id"] == to_string(expected.grade.id)
    assert actual["grades"]["initialGrade"]["system"] == String.upcase(expected.grade.system)
    assert actual["grades"]["initialGrade"]["major"] == expected.grade.major
    assert actual["grades"]["initialGrade"]["minor"] == expected.grade.minor
    assert_timestamp(actual["insertedAt"], expected.inserted_at)
    assert_timestamp(actual["updatedAt"], expected.updated_at)
    actual
  end
end
