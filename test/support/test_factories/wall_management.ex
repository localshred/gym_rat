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

      def grid_wall_factory do
        %GymRat.WallManagement.GridWall{
          angle: 45.0,
          area: build(:area),
          last_reset_at: DateTime.from_unix!(1_513_802_726_000, :milliseconds),
          name: "The old 45",
          x_width: 85,
          y_height: 28
        }
      end
    end
  end
end
