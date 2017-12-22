defmodule GymRat.TestFactories.Facilities do
  defmacro __using__(_opts) do
    quote do
      def area_factory do
        %GymRat.Facilities.Area{
          gym: build(:gym),
          name: "test area",
          order: 0
        }
      end

      def gym_factory do
        %GymRat.Facilities.Gym{
          address: "401 S 850 E, Lehi, UT 84043",
          name: "Momentum Lehi",
          website: "https://www.momentumclimbing.com/lehi/"
        }
      end
    end
  end
end
