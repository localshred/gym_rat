defmodule GymRatWeb.Graphql.Grades.MutationsTest do
  use GymRatWeb.ConnCase

  import GymRat.TestFactories

  alias GymRat.RouteManagement
  alias GymRat.Lore

  describe "create_grade" do
    test "creates a grade with the given parameters" do
      query_name = "createGrade"

      query = """
        mutation #{query_name}(
          $system: GradeSystem!,
          $major: String!,
          $minor: String!,
          $difficulty: GradeDifficulty!
        ) {
          createGrade(grade: {
            system: $system,
            major: $major,
            minor: $minor,
            difficulty: $difficulty
          }) {
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

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "system" => "YDS",
          "major" => "11",
          "minor" => "c",
          "difficulty" => "HARD"
        }
      ]

      before_count = RouteManagement.count_grades()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "createGrade", "grade"])
      |> assert_grade(run_options[:variables])

      after_count = RouteManagement.count_grades()
      assert before_count + 1 == after_count
    end

    test "does not require a grade difficulty" do
      query_name = "createGrade"

      query = """
        mutation #{query_name}(
          $system: GradeSystem!,
          $major: String!,
          $minor: String!
        ) {
          createGrade(grade: {
            system: $system,
            major: $major,
            minor: $minor
          }) {
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

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "system" => "YDS",
          "major" => "11",
          "minor" => "c"
        }
      ]

      before_count = RouteManagement.count_grades()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "createGrade", "grade"])
      |> assert_grade(run_options[:variables])

      after_count = RouteManagement.count_grades()
      assert before_count + 1 == after_count
    end
  end

  describe "delete_grade" do
    test "deletes a grade by ID" do
      grade = insert(:grade)
      query_name = "deleteGrade"

      query = """
        mutation #{query_name}(
          $id: ID!
        ) {
          deleteGrade(query: { id: $id }) {
            success
            deletedCount
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{"id" => to_string(grade.id)}
      ]

      before_count = RouteManagement.count_grades()

      delete_result =
        run_options
        |> graphql_run()
        |> Lore.path([:data, "deleteGrade"])

      assert delete_result["success"] == true
      assert delete_result["deletedCount"] == 1

      after_count = RouteManagement.count_grades()
      assert before_count - 1 == after_count
    end

    test "returns false success and 0 deletedCount when given grade ID doesn't exist" do
      grade_id = -1

      assert RouteManagement.count_grades() == 0

      query_name = "deleteGrade"

      query = """
        mutation #{query_name}(
          $id: ID!
        ) {
          deleteGrade(query: { id: $id }) {
            success
            deletedCount
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{"id" => to_string(grade_id)}
      ]

      delete_result =
        run_options
        |> graphql_run()
        |> Lore.path([:data, "deleteGrade"])

      assert delete_result["success"] == false
      assert delete_result["deletedCount"] == 0
      assert RouteManagement.count_grades() == 0
    end
  end

  describe "update_grade" do
    test "updates an existing grade with the given parameters" do
      existing_grade = insert(:grade)
      query_name = "updateGrade"

      query = """
        mutation #{query_name}(
          $id: ID!,
          $system: GradeSystem!,
          $major: String!,
          $minor: String!,
          $difficulty: GradeDifficulty!
        ) {
          updateGrade(query: { id: $id }, grade: {
            system: $system,
            major: $major,
            minor: $minor,
            difficulty: $difficulty
          }) {
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

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(existing_grade.id),
          "system" => "YDS",
          "major" => "14",
          "minor" => "a",
          "difficulty" => "BENCHMARK"
        }
      ]

      before_count = RouteManagement.count_grades()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "updateGrade", "grade"])
      |> assert_grade(run_options[:variables])

      after_count = RouteManagement.count_grades()
      assert before_count == after_count
    end

    test "returns null when the grade doesn't exist with the given ID" do
      grade_id = -1

      assert RouteManagement.count_grades() == 0

      query_name = "updateGrade"

      query = """
        mutation #{query_name}(
          $id: ID!,
          $system: GradeSystem!,
          $major: String!,
          $minor: String!,
          $difficulty: GradeDifficulty!
        ) {
          updateGrade(query: { id: $id }, grade: {
            system: $system,
            major: $major,
            minor: $minor,
            difficulty: $difficulty
          }) {
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

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(grade_id),
          "system" => "YDS",
          "major" => "15",
          "minor" => "c",
          "difficulty" => "HARD"
        }
      ]

      run_options
      |> graphql_run(:expect_errors)
      |> assert_contains_error("Unable to update grade")

      assert RouteManagement.count_grades() == 0
    end

    test "allows removing a grade difficulty (instead of replacing it)" do
      existing_grade = insert(:grade, difficulty: "HARD")
      query_name = "updateGrade"

      query = """
        mutation #{query_name}(
          $id: ID!,
          $difficulty: GradeDifficulty!
        ) {
        updateGrade(
          query: { id: $id },
          grade: { difficulty: $difficulty }
        ) {
            grade {
              id
              difficulty
            }
          }
        }
      """

      run_options = [
        query: query,
        query_name: query_name,
        variables: %{
          "id" => to_string(existing_grade.id),
          "difficulty" => "__NO_VALUE"
        }
      ]

      before_count = RouteManagement.count_grades()

      run_options
      |> graphql_run()
      |> Lore.path([:data, "updateGrade", "grade"])
      |> (fn actual ->
        assert actual["difficulty"] == nil
      end).()

      after_count = RouteManagement.count_grades()
      assert before_count == after_count
    end
  end

  def assert_grade(actual, expected) do
    assert actual["id"] != nil
    assert actual["system"] == String.upcase(expected["system"])
    assert actual["major"] == expected["major"]
    assert actual["minor"] == expected["minor"]
    if Map.has_key?(expected, "difficulty") do
      assert actual["difficulty"] == String.upcase(expected["difficulty"])
    else
      assert actual["difficulty"] == nil
    end
    actual
  end
end
