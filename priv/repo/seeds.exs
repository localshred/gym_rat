defmodule SeedsHelper do
  @now DateTime.utc_now()

  def build_grade(system, major, minor \\ nil, difficulty \\ nil) do
    %{
      system: system,
      major: major,
      minor: minor,
      difficulty: difficulty,
      inserted_at: @now,
      updated_at: @now
    }
  end
end

yds_minor_grades = ["a", "a/b", "b", "b/c", "c", "c/d", "d"]

hueco_grades = Enum.map(0..17, &(SeedsHelper.build_grade("hueco", Integer.to_string(&1))))
yds_base_grades = Enum.map(0..9, &(SeedsHelper.build_grade("yds", Integer.to_string(&1))))
yds_advanced_grades = Enum.flat_map(
  10..15,
  fn major -> Enum.map(
    yds_minor_grades,
    fn minor -> SeedsHelper.build_grade("yds", Integer.to_string(major), minor) end
  )
  end
)

grades = Enum.concat([
  hueco_grades,
  yds_base_grades,
  yds_advanced_grades
])

grades_result = GymRat.Repo.insert_all(GymRat.RouteManagement.Grade, grades)

IO.inspect(grades_result)
