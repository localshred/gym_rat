defmodule GymRat.TestFactories.WallManagement do
  defmacro __using__(_opts) do
    quote do
      def grid_hold_factory do
        %GymRat.WallManagement.GridHold{
          area: build(:area),
          grid_coordinate_x: 35.0,
          grid_coordinate_y: 14.0,
          hold: build(:hold)
        }
      end
    end
  end
end
