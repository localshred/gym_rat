defmodule GymRatWeb.Graphql.Grades.Mutations do
  use Absinthe.Schema.Notation

  alias GymRat.Graphql
  alias GymRat.Lore
  alias GymRat.RouteManagement

  input_object :create_grade_input do
    field(:system, non_null(:grade_system))
    field(:major, non_null(:string))
    field(:minor, :string)
    field(:difficulty, :grade_difficulty)
  end

  object :create_grade_response do
    field(:grade, non_null(:grade))
  end

  input_object :update_grade_input do
    field(:system, :grade_system)
    field(:major, :string)
    field(:minor, :string)
    field(:difficulty, :grade_difficulty)
  end

  object :update_grade_response do
    field(:grade, non_null(:grade))
  end

  object :grades_mutations do
    field :create_grade, non_null(:create_grade_response) do
      arg(:grade, non_null(:create_grade_input))
      resolve(&create_grade/2)
    end

    field :delete_grade, non_null(:delete_record_response) do
      arg(:query, non_null(:get_record_input))
      resolve(&delete_grade/2)
    end

    field :update_grade, non_null(:update_grade_response) do
      arg(:query, non_null(:get_record_input))
      arg(:grade, non_null(:update_grade_input))
      resolve(&update_grade/2)
    end
  end

  def create_grade(args, _context) do
    args
    |> Lore.prop(:grade)
    |> RouteManagement.create_grade()
    |> Graphql.db_result_to_response(:grade)
  end

  def delete_grade(args, _context) do
    args
    |> Lore.path([:query, :id])
    |> RouteManagement.get_grade()
    |> Graphql.delete_record(&RouteManagement.delete_grade/1)
  end

  def update_grade(args, _context) do
    try do
      args
      |> Lore.path([:query, :id])
      |> RouteManagement.get_grade!()
      |> RouteManagement.update_grade(args.update)
      |> Graphql.db_result_to_response(:grade)
    rescue
      _exception ->
        Lore.error("Unable to update grade")
    end
  end
end
