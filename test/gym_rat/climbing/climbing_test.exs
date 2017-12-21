defmodule GymRat.ClimbingTest do
  use GymRat.DataCase

  import GymRat.TestFactories

  alias GymRat.Climbing

  describe "ticks" do
    alias GymRat.Climbing.Tick

    @update_attrs %{
      number_tries: 43,
      rating: 43,
      route_id: 43,
      send_type: "some updated send_type",
      ticked_at: DateTime.from_unix!(1513806326000, :milliseconds),
      user_grade_id: 43,
      user_id: 43
    }
    @invalid_attrs %{
      number_tries: nil,
      rating: nil,
      route_id: nil,
      send_type: nil,
      ticked_at: nil,
      user_grade_id: nil,
      user_id: nil
    }

    test "list_ticks/0 returns all ticks" do
      tick = insert(:tick)
      expected_tick = Climbing.get_tick!(tick.id)
      assert Climbing.list_ticks() == [expected_tick]
    end

    test "get_tick!/1 returns the tick with given id" do
      tick = insert(:tick)
      expected_tick = Climbing.get_tick!(tick.id)
      assert tick.number_tries == expected_tick.number_tries
      assert tick.rating == expected_tick.rating
      assert tick.route_id == expected_tick.route_id
      assert tick.send_type == expected_tick.send_type
      assert DateTime.to_unix(tick.ticked_at, :milliseconds) == DateTime.to_unix(expected_tick.ticked_at, :milliseconds)
      assert tick.user_grade_id == expected_tick.user_grade_id
      assert tick.user_id == expected_tick.user_id
    end

    test "create_tick/1 with valid data creates a tick" do
      expected_tick = params_with_assocs(:tick)
      assert {:ok, %Tick{} = tick} = Climbing.create_tick(expected_tick)
      assert tick.number_tries == expected_tick.number_tries
      assert tick.rating == expected_tick.rating
      assert tick.route_id == expected_tick.route_id
      assert tick.send_type == expected_tick.send_type
      assert DateTime.to_unix(tick.ticked_at, :milliseconds) == DateTime.to_unix(expected_tick.ticked_at, :milliseconds)
      assert tick.user_grade_id == expected_tick.user_grade_id
      assert tick.user_id == expected_tick.user_id
    end

    test "create_tick/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Climbing.create_tick(@invalid_attrs)
    end

    test "update_tick/2 with valid data updates the tick" do
      user = insert(:user)
      route = insert(:route)
      tick = insert(:tick)
      attributes = %{ @update_attrs |
        route_id: route.id,
        user_id: user.id,
      }
      assert {:ok, tick} = Climbing.update_tick(tick, attributes)
      assert %Tick{} = tick
      assert tick.number_tries == 43
      assert tick.rating == 43
      assert tick.route_id == route.id
      assert tick.send_type == "some updated send_type"
      assert tick.ticked_at == DateTime.from_unix!(1513806326000, :milliseconds)
      assert tick.user_grade_id == 43
      assert tick.user_id == user.id
    end

    test "update_tick/2 with invalid data returns error changeset" do
      tick = insert(:tick)
      tick_before_update = Climbing.get_tick!(tick.id)
      assert {:error, %Ecto.Changeset{}} = Climbing.update_tick(tick, @invalid_attrs)
      assert tick_before_update == Climbing.get_tick!(tick.id)
    end

    test "delete_tick/1 deletes the tick" do
      tick = insert(:tick)
      assert {:ok, %Tick{}} = Climbing.delete_tick(tick)
      assert_raise Ecto.NoResultsError, fn -> Climbing.get_tick!(tick.id) end
    end

    test "change_tick/1 returns a tick changeset" do
      tick = insert(:tick)
      assert %Ecto.Changeset{} = Climbing.change_tick(tick)
    end
  end
end
