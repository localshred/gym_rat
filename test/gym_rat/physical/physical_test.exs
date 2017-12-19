defmodule GymRat.PhysicalTest do
  use GymRat.DataCase

  alias GymRat.Physical

  describe "gyms" do
    alias GymRat.Physical.Gym

    @valid_attrs %{address: "some address", name: "some name", website: "some website"}
    @update_attrs %{address: "some updated address", name: "some updated name", website: "some updated website"}
    @invalid_attrs %{address: nil, name: nil, website: nil}

    def gym_fixture(attrs \\ %{}) do
      {:ok, gym} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Physical.create_gym()

      gym
    end

    test "list_gyms/0 returns all gyms" do
      gym = gym_fixture()
      assert Physical.list_gyms() == [gym]
    end

    test "get_gym!/1 returns the gym with given id" do
      gym = gym_fixture()
      assert Physical.get_gym!(gym.id) == gym
    end

    test "create_gym/1 with valid data creates a gym" do
      assert {:ok, %Gym{} = gym} = Physical.create_gym(@valid_attrs)
      assert gym.address == "some address"
      assert gym.name == "some name"
      assert gym.website == "some website"
    end

    test "create_gym/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Physical.create_gym(@invalid_attrs)
    end

    test "update_gym/2 with valid data updates the gym" do
      gym = gym_fixture()
      assert {:ok, gym} = Physical.update_gym(gym, @update_attrs)
      assert %Gym{} = gym
      assert gym.address == "some updated address"
      assert gym.name == "some updated name"
      assert gym.website == "some updated website"
    end

    test "update_gym/2 with invalid data returns error changeset" do
      gym = gym_fixture()
      assert {:error, %Ecto.Changeset{}} = Physical.update_gym(gym, @invalid_attrs)
      assert gym == Physical.get_gym!(gym.id)
    end

    test "delete_gym/1 deletes the gym" do
      gym = gym_fixture()
      assert {:ok, %Gym{}} = Physical.delete_gym(gym)
      assert_raise Ecto.NoResultsError, fn -> Physical.get_gym!(gym.id) end
    end

    test "change_gym/1 returns a gym changeset" do
      gym = gym_fixture()
      assert %Ecto.Changeset{} = Physical.change_gym(gym)
    end
  end
end
