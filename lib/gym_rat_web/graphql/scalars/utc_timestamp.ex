defmodule GymRatWeb.Graphql.Scalars.UtcTimestamp do
  use Absinthe.Schema.Notation

  alias Absinthe.Blueprint.Input
  alias GymRat.Lore

  scalar :utc_timestamp do
    description("A Unix Timestamp in UTC milliseconds, converting to/from a DateTime")
    parse(&parse_timestamp/1)
    serialize(&serialize_datetime/1)
  end

  def parse_timestamp(%Input.String{value: epochMilliseconds}) when is_binary(epochMilliseconds) do
    integer =
      epochMilliseconds
      |> Integer.parse(10)
      |> parse_timestamp()

    parse_timestamp(%Input.Integer{value: integer})
  end

  def parse_timestamp(%Input.Integer{value: epochMilliseconds}) when is_integer(epochMilliseconds) do
    epochMilliseconds
    |> DateTime.from_unix!(:milliseconds)
    |> DateTime.to_naive()
    |> Lore.ok()
  end

  def parse_timestamp(%Input.Null{}) do
    Lore.ok(nil)
  end

  def parse_timestamp(_) do
    :error
  end

  def serialize_datetime(dateTime) when is_binary(dateTime) do
    dateTime
    |> DateTime.from_iso8601()
    |> serialize_datetime()
  end

  def serialize_datetime(%NaiveDateTime{} = dateTime) do
    dateTime
    |> NaiveDateTime.to_iso8601()
    |> Lore.append("Z")
    |> serialize_datetime()
  end

  def serialize_datetime({:ok, %DateTime{} = dateTime, _offset}) do
    dateTime
    |> serialize_datetime()
  end

  def serialize_datetime(%DateTime{} = dateTime) do
    DateTime.to_unix(dateTime, :milliseconds)
  end

  def serialize_datetime(_) do
    nil
  end
end
