defmodule GymRat.TestFactories.RouteManagement do
  defmacro __using__(_opts) do
    quote do
      def grade_factory do
        %GymRat.RouteManagement.Grade{
          system: "yds",
          major: "13",
          minor: "a",
          difficulty: "benchmark"
        }
      end

      def hold_placement_factory do
        %GymRat.RouteManagement.HoldPlacement{
          grid_coordinate_x: 35,
          grid_coordinate_y: 14,
          hold: build(:hold),
          is_finish: false,
          is_start: true,
          route: build(:route)
        }
      end

      def route_factory do
        %GymRat.RouteManagement.Route{
          setter: build(:user),
          area: build(:area),
          color: "red",
          set_on: DateTime.from_unix!(1_513_802_726_000, :milliseconds),
          expires_on: DateTime.from_unix!(1_515_802_726_000, :milliseconds),
          # TODO make a real association
          grade_id: 42
        }
      end
    end
  end
end
