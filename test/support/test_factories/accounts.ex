defmodule GymRat.TestFactories.Accounts do
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %GymRat.Accounts.User{
          email: "boundbysixstringstothisworld@gmail.com",
          name: "Johnny X",
          username: "oneturnoutoftune"
        }
      end
    end
  end
end
