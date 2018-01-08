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
          area: build(:area),
          grid_coordinate_x: 35.0,
          grid_coordinate_y: 14.0,
          hold: build(:hold)
        }
      end

      def route_factory do
        %GymRat.RouteManagement.Route{
          area: build(:area),
          name: "Big Joe",
          color: "red",
          expires_on: DateTime.from_unix!(1_515_802_726_000, :milliseconds),
          grade: build(:grade),
          set_on: DateTime.from_unix!(1_513_802_726_000, :milliseconds),
          setter: build(:user)
        }
      end
    end
  end
end
