defmodule GymRatWeb.Graphql.Areas.QueriesTest do
  use GymRatWeb.ConnCase

  import GymRat.TestFactories

  alias GymRat.Facilities
  alias GymRat.Lore

  describe "area" do
    test "gets a area by ID" do
      expected_area = insert(:area)

      query_name = "getArea"

      query = """
        query #{query_name}($id: ID!) {
          area(query: { id: $id }) {
            area {
              id
              gym {
                id
                name
              }
              name
              order
              insertedAt
              updatedAt
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(expected_area.id)
        }
      ]
      |> graphql_run()
      |> Lore.path([:data, "area", "area"])
      |> assert_area(expected_area)
    end

    test "gets a null area when given ID that doesn't exist in DB" do
      area_id = -1

      assert Facilities.count_areas() == 0

      query_name = "getArea"

      query = """
        query #{query_name}($id: ID!) {
          area(query: { id: $id }) {
            area {
              id
              name
              order
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(area_id)
        }
      ]
      |> graphql_run()
      |> Lore.path([:data, "area", "area"])
      |> (fn area ->
            assert area == nil
          end).()
    end

    # test "fetches associated areas" do
    #   expected_gym = insert(:gym)
    #   insert_list(3, :area, gym: expected_gym)

    #   query_name = "getGymAreas"

    #   query = """
    #     query #{query_name}($id: ID!) {
    #       gym(query: { id: $id }) {
    #         gym {
    #           id
    #           areas {
    #             id
    #             name
    #             order
    #           }
    #         }
    #       }
    #     }
    #   """

    #   [
    #     query: query,
    #     query_name: query_name,
    #     variables: %{
    #       "id" => to_string(expected_gym.id)
    #     }
    #   ]
    #   |> graphql_run()
    #   |> Lore.path([:data, "gym", "gym"])
    #   |> (fn %{"id" => gym_id, "areas" => areas} ->
    #         assert gym_id == to_string(expected_gym.id)
    #         assert length(areas) == 3

    #         Enum.each(areas, fn area ->
    #           assert area["id"] != nil
    #           assert area["name"] != nil
    #         end)
    #       end).()
    # end
  end

  describe "areas" do
    test "gets all areas when no IDs are given" do
      expected_areas =
        insert_list(3, :area)
        |> Enum.group_by(fn area -> area |> Lore.prop(:id) |> to_string() end)

      query_name = "getAreas"

      query = """
        query #{query_name} {
          areas(query: {}) {
            areas {
              id
              gym {
                id
                name
              }
              name
              order
              insertedAt
              updatedAt
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name
      ]
      |> graphql_run()
      |> Lore.path([:data, "areas", "areas"])
      |> Enum.each(fn actual_area ->
        expected_area = List.first(expected_areas[actual_area["id"]])
        assert_area(actual_area, expected_area)
      end)
    end

    test "gets only areas with given IDs" do
      areas_picked_count = 2
      areas_total_count = 4
      areas = insert_list(areas_total_count, :area)

      area_ids =
        areas
        |> Enum.take(areas_picked_count)
        |> Enum.map(Lore.prop(:id))
        |> Enum.map(&to_string/1)

      expected_areas =
        areas
        |> Enum.group_by(fn area -> area |> Lore.prop(:id) |> to_string() end)

      query_name = "getAreas"

      query = """
        query #{query_name}(
          $ids: [String!]!
        ){
          areas(query: {
            ids: $ids
          }) {
            areas {
              id
              gym {
                id
                name
              }
              name
              order
              insertedAt
              updatedAt
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{"ids" => area_ids}
      ]
      |> graphql_run()
      |> Lore.path([:data, "areas", "areas"])
      |> Lore.each(fn actual_area ->
        expected_area = List.first(expected_areas[actual_area["id"]])
        assert_area(actual_area, expected_area)
      end)
      |> (fn areas ->
            assert length(areas) == areas_picked_count
          end).()
    end

    test "retrieves empty list when no areas found for given args" do
      query_name = "getAreas"

      query = """
        query #{query_name} {
          areas(query: {}) {
            areas {
              id
            }
          }
        }
      """

      assert Facilities.count_areas() == 0

      [
        query: query,
        query_name: query_name
      ]
      |> graphql_run()
      |> Lore.path([:data, "areas", "areas"])
      |> (fn areas ->
            assert length(areas) == 0
          end).()
    end
  end

  def assert_area(actual, expected) do
    assert actual["id"] == to_string(expected.id)
    assert actual["gym"]["id"] == to_string(expected.gym.id)
    assert actual["gym"]["name"] == expected.gym.name
    assert actual["name"] == expected.name
    assert actual["order"] == expected.order
    assert_timestamp(actual["insertedAt"], expected.inserted_at)
    assert_timestamp(actual["updatedAt"], expected.updated_at)
  end
end
