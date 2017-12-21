defmodule GymRat.TestFactories.RouteManagement do
  defmacro __using__(_opts) do
    quote do

      def hold_placement_factory do
        %GymRat.RouteManagement.HoldPlacement{
          grid_coordinate_x: 35,
          grid_coordinate_y: 14,
          hold: build(:hold),
          is_finish: false,
          is_start: true,
          route: build(:route),
        }
      end

      def route_factory do
        %GymRat.RouteManagement.Route{
          setter: build(:user),
          area_id: build(:area),
          color: "red",
          set_on: DateTime.from_unix!(1513802726000, :milliseconds),
          expires_on: DateTime.from_unix!(1515802726000, :milliseconds)
        }
      end

    end
  end
end
