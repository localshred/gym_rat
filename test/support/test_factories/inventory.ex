defmodule GymRat.TestFactories.Inventory do
  defmacro __using__(_opts) do
    quote do
      def hold_factory do
        %GymRat.Inventory.Hold{
          color: "wood",
          count: 13,
          features: "crimpy",
          maker: "metolius",
          material: "wood",
          primary_use: "hand",
          size: "small"
        }
      end
    end
  end
end
