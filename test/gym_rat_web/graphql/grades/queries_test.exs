defmodule GymRatWeb.Graphql.Grades.QueriesTest do
  use GymRatWeb.ConnCase

  import GymRat.TestFactories

  alias GymRat.RouteManagement
  alias GymRat.Lore

  describe "grade" do
    test "gets a grade by ID" do
      expected_grade = insert(:grade)

      query_name = "getGrade"

      query = """
        query #{query_name}($id: ID!) {
          grade(query: { id: $id }) {
            grade {
              id
              system
              major
              minor
              difficulty
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
          "id" => to_string(expected_grade.id)
        }
      ]
      |> graphql_run()
      |> Lore.path([:data, "grade", "grade"])
      |> assert_grade(expected_grade)
    end

    test "gets a null grade when given ID that doesn't exist in DB" do
      grade_id = -1

      assert RouteManagement.count_grades() == 0

      query_name = "getGrade"

      query = """
        query #{query_name}($id: ID!) {
          grade(query: { id: $id }) {
            grade {
              id
              system
              major
              minor
              difficulty
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(grade_id)
        }
      ]
      |> graphql_run()
      |> Lore.path([:data, "grade", "grade"])
      |> (fn grade ->
            assert grade == nil
          end).()
    end
  end

  describe "grades" do
    test "gets all grades when no IDs are given" do
      expected_grades =
        insert_list(3, :grade)
        |> Enum.group_by(fn grade -> grade |> Lore.prop(:id) |> to_string() end)

      query_name = "getGrades"

      query = """
        query #{query_name} {
          grades(query: {}) {
            grades {
              id
              system
              major
              minor
              difficulty
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
      |> Lore.path([:data, "grades", "grades"])
      |> Enum.each(fn actual_grade ->
        expected_grade = List.first(expected_grades[actual_grade["id"]])
        assert_grade(actual_grade, expected_grade)
      end)
    end

    test "gets only grades with given IDs" do
      grades_picked_count = 2
      grades_total_count = 4
      grades = insert_list(grades_total_count, :grade)

      grade_ids =
        grades
        |> Enum.take(grades_picked_count)
        |> Enum.map(Lore.prop(:id))
        |> Enum.map(&to_string/1)

      expected_grades =
        grades
        |> Enum.group_by(fn grade -> grade |> Lore.prop(:id) |> to_string() end)

      query_name = "getGrades"

      query = """
        query #{query_name}(
          $ids: [String!]!
        ){
          grades(query: {
            ids: $ids
          }) {
            grades {
              id
              system
              major
              minor
              difficulty
              insertedAt
              updatedAt
            }
          }
        }
      """

      [
        query: query,
        query_name: query_name,
        variables: %{"ids" => grade_ids}
      ]
      |> graphql_run()
      |> Lore.path([:data, "grades", "grades"])
      |> Lore.each(fn actual_grade ->
        expected_grade = List.first(expected_grades[actual_grade["id"]])
        assert_grade(actual_grade, expected_grade)
      end)
      |> (fn grades ->
            assert length(grades) == grades_picked_count
          end).()
    end

    test "retrieves empty list when no grades found for given args" do
      query_name = "getGrades"

      query = """
        query #{query_name} {
          grades(query: {}) {
            grades {
              id
            }
          }
        }
      """

      assert RouteManagement.count_grades() == 0

      [
        query: query,
        query_name: query_name
      ]
      |> graphql_run()
      |> Lore.path([:data, "grades", "grades"])
      |> (fn grades ->
            assert length(grades) == 0
          end).()
    end
  end

  def assert_grade(actual, expected) do
    assert actual["id"] == to_string(expected.id)
    assert actual["system"] == String.upcase(expected.system)
    assert actual["major"] == expected.major
    assert actual["minor"] == expected.minor
    assert actual["difficulty"] == String.upcase(expected.difficulty)
    assert_timestamp(actual["insertedAt"], expected.inserted_at)
    assert_timestamp(actual["updatedAt"], expected.updated_at)
  end
end
