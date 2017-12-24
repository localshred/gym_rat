defmodule GymRatWeb.Graphql.Routes.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GymRat.Repo

  alias GymRat.Lore
  alias GymRat.RouteManagement

  @desc "Breakdown of grades that may be assigned or derived for a route"
  object :route_grades do
    field(:initial_grade, non_null(:grade))
  end

  @desc "A route that has been set for climbers"
  object :route do
    field(:id, non_null(:id))
    field(:area, non_null(:area), resolve: assoc(:area))
    field(:setter, non_null(:user), resolve: assoc(:setter))
    field(:name, :string)
    field(:color, non_null(:string))
    field(:grades, non_null(:route_grades), resolve: &extract_grade/3)
    field(:ticks, :tick |> non_null |> list_of, resolve: assoc(:ticks))
    field(:set_on, non_null(:utc_timestamp))
    field(:expires_on, :utc_timestamp)
    field(:inserted_at, non_null(:utc_timestamp))
    field(:updated_at, non_null(:utc_timestamp))
  end

  def extract_grade(%{grade_id: grade_id, grade: grade}, _args, _context) do
    grade
    |> fetch_grade_if_missing(grade_id)
    |> Lore.assoc_prop(:initial_grade)
    |> Lore.ok()
  end

  def fetch_grade_if_missing(nil, grade_id) do
    RouteManagement.get_grade!(grade_id)
  end

  def fetch_grade_if_missing(grade, _grade_id) do
    grade
  end
end
