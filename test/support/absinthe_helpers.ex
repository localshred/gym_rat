defmodule GymRat.AbsintheHelpers do
  defmacro __using__(_other) do
    quote do
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
    end
  end
end
