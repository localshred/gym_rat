defmodule GymRatWeb.Graphql.Routes.MutationsTest do
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

  describe "create_route" do
    test "creates a route with the given parameters" do
      query_name = "createRoute"

      query = """
        mutation #{query_name}(
          $areaId: ID!,
          $gradeId: ID!,
          $setterId: ID!,
          $name: String!
          $color: String!,
          $setOn: UtcTimestamp!,
          $expiresOn: UtcTimestamp!
        ) {
          createRoute(route: {
            areaId: $areaId,
            gradeId: $gradeId,
            setterId: $setterId,
            name: $name,
            color: $color,
            setOn: $setOn,
            expiresOn: $expiresOn
          }) {
            route {
              #{@route_fields}
            }
          }
        }
      """

      area = insert(:area)
      grade = insert(:grade)
      setter = insert(:user)

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "areaId" => to_string(area.id),
          "gradeId" => to_string(grade.id),
          "setterId" => to_string(setter.id),
          "name" => "some route name",
          "color" => "puce",
          "setOn" => 1_515_802_626_000,
          "expiresOn" => 1_515_902_726_000
        }
      ]

      before_count = RouteManagement.count_routes()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "createRoute", "route"])
      |> assert_route(run_options[:variables], area, setter, grade)

      after_count = RouteManagement.count_routes()
      assert before_count + 1 == after_count
    end
  end

  describe "delete_route" do
    test "deletes a route by ID" do
      route = insert(:route)
      query_name = "deleteRoute"

      query = """
        mutation #{query_name}(
          $id: ID!
        ) {
          deleteRoute(query: { id: $id }) {
            success
            deletedCount
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{"id" => to_string(route.id)}
      ]

      before_count = RouteManagement.count_routes()

      delete_result =
        run_options
        |> graphql_run()
        |> Lore.path([:data, "deleteRoute"])

      assert delete_result["success"] == true
      assert delete_result["deletedCount"] == 1

      after_count = RouteManagement.count_routes()
      assert before_count - 1 == after_count
    end

    test "returns false success and 0 deletedCount when given route ID doesn't exist" do
      route_id = -1

      assert RouteManagement.count_routes() == 0

      query_name = "deleteRoute"

      query = """
        mutation #{query_name}(
          $id: ID!
        ) {
          deleteRoute(query: { id: $id }) {
            success
            deletedCount
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{"id" => to_string(route_id)}
      ]

      delete_result =
        run_options
        |> graphql_run()
        |> Lore.path([:data, "deleteRoute"])

      assert delete_result["success"] == false
      assert delete_result["deletedCount"] == 0
      assert RouteManagement.count_routes() == 0
    end
  end

  describe "update_route" do
    test "updates an existing route with the given parameters" do
      existing_route = insert(:route)
      query_name = "updateRoute"

      query = """
        mutation #{query_name}(
          $id: ID!,
          $areaId: ID!,
          $gradeId: ID!,
          $setterId: ID!,
          $name: String!
          $color: String!,
          $setOn: UtcTimestamp!,
          $expiresOn: UtcTimestamp!
        ) {
          updateRoute(query: { id: $id }, route: {
            areaId: $areaId,
            gradeId: $gradeId,
            setterId: $setterId,
            name: $name,
            color: $color,
            setOn: $setOn,
            expiresOn: $expiresOn
          }) {
            route {
              #{@route_fields}
            }
          }
        }
      """

      area = insert(:area)
      grade = insert(:grade)
      setter = insert(:user)

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(existing_route.id),
          "areaId" => to_string(area.id),
          "gradeId" => to_string(grade.id),
          "setterId" => to_string(setter.id),
          "name" => "some route name",
          "color" => "puce",
          "setOn" => 1_515_802_626_000,
          "expiresOn" => 1_515_902_726_000
        }
      ]

      before_count = RouteManagement.count_routes()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "updateRoute", "route"])
      |> assert_route(run_options[:variables], area, setter, grade)

      after_count = RouteManagement.count_routes()
      assert before_count == after_count
    end

    test "returns null when the route doesn't exist with the given ID" do
      route_id = -1

      assert RouteManagement.count_routes() == 0

      query_name = "updateRoute"

      query = """
        mutation #{query_name}(
          $id: ID!,
          $areaId: ID!,
        ) {
          updateRoute(
            query: { id: $id },
            route: { areaId: $areaId }
          ) {
            route {
              #{@route_fields}
            }
          }
        }
      """

      area = insert(:area)

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(route_id),
          "areaId" => to_string(area.id)
        }
      ]

      run_options
      |> graphql_run(:expect_errors)
      |> assert_contains_error("Unable to update route")

      assert RouteManagement.count_routes() == 0
    end
  end

  def assert_route(actual, expected_route, area, setter, grade) do
    if Map.has_key?(expected_route, "id") do
      assert actual["id"] == to_string(expected_route["id"])
    end
    assert actual["name"] == expected_route["name"]
    assert actual["color"] == expected_route["color"]
    assert_timestamp(actual["setOn"], expected_route["setOn"])
    assert_timestamp(actual["expiresOn"], expected_route["expiresOn"])
    assert actual["area"]["id"] == to_string(area.id)
    assert actual["area"]["name"] == area.name
    assert actual["setter"]["id"] == to_string(setter.id)
    assert actual["setter"]["name"] == setter.name
    assert actual["grades"]["initialGrade"]["id"] == to_string(grade.id)
    assert actual["grades"]["initialGrade"]["system"] == String.upcase(grade.system)
    assert actual["grades"]["initialGrade"]["major"] == grade.major
    assert actual["grades"]["initialGrade"]["minor"] == grade.minor
    refute actual["insertedAt"] == nil
    refute actual["updatedAt"] == nil
    actual
  end
end
