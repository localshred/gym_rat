defmodule GymRat.ClimbingTest do
  use GymRat.DataCase

  alias GymRat.Climbing

  describe "ticks" do
    alias GymRat.Climbing.Tick

    @valid_attrs %{number_tries: 42, rating: 42, route_id: 42, send_type: "some send_type", sent_on: ~T[14:00:00.000000], user_grade_id: 42, user_id: 42}
    @update_attrs %{number_tries: 43, rating: 43, route_id: 43, send_type: "some updated send_type", sent_on: ~T[15:01:01.000000], user_grade_id: 43, user_id: 43}
    @invalid_attrs %{number_tries: nil, rating: nil, route_id: nil, send_type: nil, sent_on: nil, user_grade_id: nil, user_id: nil}

    def tick_fixture(attrs \\ %{}) do
      {:ok, tick} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Climbing.create_tick()

      tick
    end

    test "list_ticks/0 returns all ticks" do
      tick = tick_fixture()
      assert Climbing.list_ticks() == [tick]
    end

    test "get_tick!/1 returns the tick with given id" do
      tick = tick_fixture()
      assert Climbing.get_tick!(tick.id) == tick
    end

    test "create_tick/1 with valid data creates a tick" do
      assert {:ok, %Tick{} = tick} = Climbing.create_tick(@valid_attrs)
      assert tick.number_tries == 42
      assert tick.rating == 42
      assert tick.route_id == 42
      assert tick.send_type == "some send_type"
      assert tick.sent_on == ~T[14:00:00.000000]
      assert tick.user_grade_id == 42
      assert tick.user_id == 42
    end

    test "create_tick/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Climbing.create_tick(@invalid_attrs)
    end

    test "update_tick/2 with valid data updates the tick" do
      tick = tick_fixture()
      assert {:ok, tick} = Climbing.update_tick(tick, @update_attrs)
      assert %Tick{} = tick
      assert tick.number_tries == 43
      assert tick.rating == 43
      assert tick.route_id == 43
      assert tick.send_type == "some updated send_type"
      assert tick.sent_on == ~T[15:01:01.000000]
      assert tick.user_grade_id == 43
      assert tick.user_id == 43
    end

    test "update_tick/2 with invalid data returns error changeset" do
      tick = tick_fixture()
      assert {:error, %Ecto.Changeset{}} = Climbing.update_tick(tick, @invalid_attrs)
      assert tick == Climbing.get_tick!(tick.id)
    end

    test "delete_tick/1 deletes the tick" do
      tick = tick_fixture()
      assert {:ok, %Tick{}} = Climbing.delete_tick(tick)
      assert_raise Ecto.NoResultsError, fn -> Climbing.get_tick!(tick.id) end
    end

    test "change_tick/1 returns a tick changeset" do
      tick = tick_fixture()
      assert %Ecto.Changeset{} = Climbing.change_tick(tick)
    end
  end
end
