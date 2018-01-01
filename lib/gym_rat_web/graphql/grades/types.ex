defmodule GymRatWeb.Graphql.Grades.Types do
  use Absinthe.Schema.Notation

  alias GymRat.Graphql

  @desc "The grading system"
  enum :grade_system do
    value(:font, description: "Fontainebleau bouldering system")
    value(:french, description: "French grading scale (similar to Font)")
    value(:hueco, description: "John Sherman's V-scale for bouldering")
    value(:yds, description: "Yosemite Decimal System")
    value(:points, description: "An arbitrary point value system used for scoring")
  end

  @desc "Modifies the associated grade's difficulty (e.g. 5.12- would be a 'soft' 5.12)"
  enum :grade_difficulty do
    value(:__no_value, description: "Used to indicate that no value should be stored")
    value(:benchmark, description: "Benchmark for the grade")
    value(:soft, description: "Soft for the grade")
    value(:hard, description: "Hard for the grade")
  end

  @desc "A grade that may be assigned to a route or boulder problem"
  object :grade do
    field(:id, non_null(:id), description: "The database ID of the grade")
    field(
      :system,
      non_null(:grade_system),
      resolve: Graphql.enum_value_resolver(:system),
      description: "The grading system (e.g. YDS, Font, etc)"
    )
    field(:major, non_null(:string), description: "The primary grade (e.g. the '10' in 5.10a)")
    field(:minor, :string, description: "The secondary grade (e.g. the 'a' in 5.10a)")
    field(
      :difficulty,
      :grade_difficulty,
      resolve: Graphql.enum_value_resolver(:difficulty),
      description: "A difficulty modifier for the grade"
    )
    field(:inserted_at, non_null(:utc_timestamp))
    field(:updated_at, non_null(:utc_timestamp))
  end
end
