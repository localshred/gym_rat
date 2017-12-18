defmodule GymRatWeb.GraphQL.Grades.Types do
  use Absinthe.Schema.Notation

  enum :grade_system do
    description "The grading system"

    value :font, description: "Fontainebleau bouldering system"
    value :french, description: "French grading scale (similar to Font)"
    value :hueco, description: "John Sherman's V-scale for bouldering"
    value :yds, description: "Yosemite Decimal System"
    value :points, description: "An arbitrary point value system used for scoring"
  end

  enum :grade_difficulty do
    description "Modifies the associated grade's difficulty (e.g. 5.12- would be a 'soft' 5.12)"

    value :benchmark, description: "Benchmark for the grade"
    value :soft, description: "Soft for the grade"
    value :hard, description: "Hard for the grade"
  end

  @desc "A grade that may be assigned to a route or boulder problem"
  object :grade do
    field :system, non_null(:grade_system)
    field :major, non_null(:string)
    field :minor, :string
    field :tiny, :string
    field :difficulty, :grade_difficulty
  end
end
