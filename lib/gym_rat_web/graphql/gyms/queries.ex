defmodule GymRatWeb.Graphql.Gyms.Queries do
  use Absinthe.Schema.Notation

  object :gym_response do
    field :gym, non_null(:gym)
  end

  object :gyms_response do
    field :gyms, :gym |> non_null |> list_of |> non_null
  end

  object :gyms_queries do
    field :gyms, non_null(:gyms_response) do
      arg :query, non_null(:get_records_input)
      resolve fn (_args, _context) ->
        { :ok, %{
          gyms: [
            %{
              id: "123",
              name: "Momentum Lehi"
            }
          ]
        }}
      end
    end

    field :gym, non_null(:gym_response) do
      arg :query, non_null(:get_record_input)
      resolve fn (_args, _context) ->
        { :ok, %{
          gym: %{
            id: "123",
            name: "Momentum Lehi"
          }
        }}
      end
    end
  end
end
