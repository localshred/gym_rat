defmodule GymRat.RouteManagement.Context.GradeTest do
  use GymRat.DataCase

  import GymRat.TestFactories

  alias GymRat.RouteManagement

  describe "grades" do
    alias GymRat.RouteManagement.Grade

    @update_attrs %{
      difficulty: "some updated difficulty",
      major: "some updated major",
      minor: "some updated minor",
      system: "some updated system"
    }
    @invalid_attrs %{difficulty: nil, major: nil, minor: nil, system: nil}

    test "list_grades/0 returns all grades" do
      grade = insert(:grade)
      assert RouteManagement.list_grades() == [grade]
    end

    test "get_grade!/1 returns the grade with given id" do
      grade = insert(:grade)
      assert RouteManagement.get_grade!(grade.id) == grade
    end

    test "create_grade/1 with valid data creates a grade" do
      attributes = params_for(:grade)
      assert {:ok, %Grade{} = grade} = RouteManagement.create_grade(attributes)
      assert grade.difficulty == attributes.difficulty
      assert grade.major == attributes.major
      assert grade.minor == attributes.minor
      assert grade.system == attributes.system
    end

    test "create_grade/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RouteManagement.create_grade(@invalid_attrs)
    end

    test "update_grade/2 with valid data updates the grade" do
      grade = insert(:grade)
      assert {:ok, grade} = RouteManagement.update_grade(grade, @update_attrs)
      assert %Grade{} = grade
      assert grade.difficulty == "some updated difficulty"
      assert grade.major == "some updated major"
      assert grade.minor == "some updated minor"
      assert grade.system == "some updated system"
    end

    test "update_grade/2 with invalid data returns error changeset" do
      grade = insert(:grade)
      assert {:error, %Ecto.Changeset{}} = RouteManagement.update_grade(grade, @invalid_attrs)
      assert grade == RouteManagement.get_grade!(grade.id)
    end

    test "delete_grade/1 deletes the grade" do
      grade = insert(:grade)
      assert {:ok, %Grade{}} = RouteManagement.delete_grade(grade)
      assert_raise Ecto.NoResultsError, fn -> RouteManagement.get_grade!(grade.id) end
    end

    test "change_grade/1 returns a grade changeset" do
      grade = insert(:grade)
      assert %Ecto.Changeset{} = RouteManagement.change_grade(grade)
    end
  end
end
