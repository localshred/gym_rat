defmodule GymRat.RouteManagement do
  @moduledoc """
  The RouteManagement context for working with Grades and Routes.
  """

  alias GymRat.RouteManagement.Context.Grade
  defdelegate change_grade(grade), to: Grade
  defdelegate count_grades, to: Grade
  defdelegate create_grade(attrs), to: Grade
  defdelegate delete_grade(grade), to: Grade
  defdelegate get_grade!(id), to: Grade
  defdelegate get_grade(id), to: Grade
  defdelegate list_grades(ids), to: Grade
  defdelegate list_grades, to: Grade
  defdelegate update_grade(grade, attrs), to: Grade

  alias GymRat.RouteManagement.Context.Route
  defdelegate change_route(route), to: Route
  defdelegate count_routes, to: Route
  defdelegate create_route(attrs), to: Route
  defdelegate delete_route(route), to: Route
  defdelegate get_route!(id), to: Route
  defdelegate get_route(id), to: Route
  defdelegate list_routes(ids), to: Route
  defdelegate list_routes, to: Route
  defdelegate update_route(route, attrs), to: Route
end
