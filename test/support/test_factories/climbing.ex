defmodule GymRat.TestFactories.Climbing do
  defmacro __using__(_opts) do
    quote do
      def tick_factory do
        %GymRat.Climbing.Tick{
          number_tries: 42,
          rating: 42,
          route: build(:route),
          send_type: "some send_type",
          ticked_at: DateTime.from_unix!(1_513_802_726_000, :milliseconds),
          user: build(:user),
          # TODO grade assoc
          user_grade_id: 42
        }
      end
    end
  end
end
