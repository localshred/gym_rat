defmodule GymRat.AbsintheHelpers do
  defmacro __using__(_other) do
    quote do
      def graphql_run(options) when is_list(options) do
        query = options[:query]
        run_options = List.delete(options, :query)
        {:ok, response} = Absinthe.run(query, GymRatWeb.Graphql.Schema, run_options)
        assert response["errors"] == nil
        response
      end
    end
  end
end
