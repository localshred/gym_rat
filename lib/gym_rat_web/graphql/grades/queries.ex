defmodule GymRatWeb.Graphql.Grades.Queries do
  use Absinthe.Schema.Notation

  alias GymRat.Lore
  alias GymRat.RouteManagement

  object :grade_response do
    field(:grade, :grade)
  end

  object :grades_response do
    field(:grades, :grade |> non_null |> list_of |> non_null)
  end

  object :grades_queries do
    field :grade, non_null(:grade_response) do
      arg(:query, non_null(:get_record_input))
      resolve(&get_grade/2)
    end

    field :grades, non_null(:grades_response) do
      arg(:query, non_null(:get_records_input))
      resolve(&list_grades/2)
    end
  end

  def get_grade(args, _context) do
    args
    |> Lore.path([:query, :id])
    |> RouteManagement.get_grade()
    |> Lore.assoc_prop(:grade)
    |> Lore.ok()
  end

  def list_grades(args, _context) do
    args
    |> Lore.path([:query, :ids])
    |> Lore.default_to([])
    |> RouteManagement.list_grades()
    |> Lore.default_to([])
    |> Lore.assoc_prop(:grades)
    |> Lore.ok()
  end
end
