defmodule GymRat.Facilities.Context.GymTest do
  use GymRat.DataCase

  import GymRat.TestFactories

  alias GymRat.Facilities

  describe "gyms" do
    alias GymRat.Facilities.Gym

    @update_attrs %{
      address: "some updated address",
      name: "some updated name",
      website: "some updated website"
    }
    @invalid_attrs %{address: nil, name: nil, website: nil}

    test "list_gyms/0 returns all gyms" do
      gym = insert(:gym)
      assert Facilities.list_gyms() == [gym]
    end

    test "get_gym!/1 returns the gym with given id" do
      gym = insert(:gym)
      assert Facilities.get_gym!(gym.id) == gym
    end

    test "create_gym/1 with valid data creates a gym" do
      expected_gym = params_for(:gym)
      assert {:ok, %Gym{} = gym} = Facilities.create_gym(expected_gym)
      assert gym.address == expected_gym.address
      assert gym.name == expected_gym.name
      assert gym.website == expected_gym.website
    end

    test "create_gym/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Facilities.create_gym(@invalid_attrs)
    end

    test "update_gym/2 with valid data updates the gym" do
      gym = insert(:gym)
      assert {:ok, gym} = Facilities.update_gym(gym, @update_attrs)
      assert %Gym{} = gym
      assert gym.address == "some updated address"
      assert gym.name == "some updated name"
      assert gym.website == "some updated website"
    end

    test "update_gym/2 with invalid data returns error changeset" do
      gym = insert(:gym)
      assert {:error, %Ecto.Changeset{}} = Facilities.update_gym(gym, @invalid_attrs)
      assert gym == Facilities.get_gym!(gym.id)
    end

    test "delete_gym/1 deletes the gym" do
      gym = insert(:gym)
      assert {:ok, %Gym{}} = Facilities.delete_gym(gym)
      assert_raise Ecto.NoResultsError, fn -> Facilities.get_gym!(gym.id) end
    end

    test "change_gym/1 returns a gym changeset" do
      gym = insert(:gym)
      assert %Ecto.Changeset{} = Facilities.change_gym(gym)
    end
  end
end
