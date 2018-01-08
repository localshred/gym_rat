defmodule GymRat.AbsintheHelpers do
  defmacro __using__(_other) do
    quote do
      alias GymRat.Lore
      alias Absinthe.Blueprint.Input
      alias GymRatWeb.Graphql.Scalars.UtcTimestamp

      def graphql_run(options) when is_list(options) do
        query = options[:query]
        run_options = List.delete(options, :query)
        {:ok, response} = Absinthe.run(query, GymRatWeb.Graphql.Schema, run_options)
        assert Map.get(response, :errors, nil) == nil
        response
      end

      def graphql_run(options, :expect_errors) when is_list(options) do
        query = options[:query]
        run_options = List.delete(options, :query)
        {:ok, response} = Absinthe.run(query, GymRatWeb.Graphql.Schema, run_options)
        refute Map.get(response, :errors, nil) == nil
        response
      end

      def assert_contains_error(%{errors: errors}, expected_message) do
        errors
        |> Enum.map(Lore.prop(:message))
        |> (fn error_messages ->
              assert(
                Enum.any?(error_messages, fn error_message ->
                  error_message == expected_message
                end),
                "Didn't find the specified error message in the following error result:\n#{
                  Poison.encode!(errors)
                }"
              )
            end).()
      end

      def assert_timestamp(actualTimestamp, %DateTime{} = expectedDateTime) do
        assert_timestamp(actualTimestamp, DateTime.to_naive(expectedDateTime))
      end

      def assert_timestamp(actualTimestamp, %NaiveDateTime{} = expectedDateTime)
          when is_integer(actualTimestamp) do
        {:ok, actual} = UtcTimestamp.parse_timestamp(%Input.Integer{value: actualTimestamp})
        assert NaiveDateTime.diff(expectedDateTime, actual, :millisecond) == 0
      end

      def assert_timestamp(actualTimestamp, expectedDateTime) when is_integer(actualTimestamp) and is_integer(expectedDateTime) do
        assert actualTimestamp == expectedDateTime
      end
    end
  end
end
