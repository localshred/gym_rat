defmodule GymRat.FacilitiesTest do
  use GymRat.DataCase

  alias GymRat.Facilities

  describe "areas" do
    alias GymRat.RouteManagement.Area

    @valid_attrs %{gym_id: 42, name: "some name", order: 42}
    @update_attrs %{gym_id: 43, name: "some updated name", order: 43}
    @invalid_attrs %{gym_id: nil, name: nil, order: nil}

    def area_fixture(attrs \\ %{}) do
      {:ok, area} =
        attrs
        |> Enum.into(@valid_attrs)
        |> RouteManagement.create_area()

      area
    end

    test "list_areas/0 returns all areas" do
      area = area_fixture()
      assert RouteManagement.list_areas() == [area]
    end

    test "get_area!/1 returns the area with given id" do
      area = area_fixture()
      assert RouteManagement.get_area!(area.id) == area
    end

    test "create_area/1 with valid data creates a area" do
      assert {:ok, %Area{} = area} = RouteManagement.create_area(@valid_attrs)
      assert area.gym_id == 42
      assert area.name == "some name"
      assert area.order == 42
    end

    test "create_area/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RouteManagement.create_area(@invalid_attrs)
    end

    test "update_area/2 with valid data updates the area" do
      area = area_fixture()
      assert {:ok, area} = RouteManagement.update_area(area, @update_attrs)
      assert %Area{} = area
      assert area.gym_id == 43
      assert area.name == "some updated name"
      assert area.order == 43
    end

    test "update_area/2 with invalid data returns error changeset" do
      area = area_fixture()
      assert {:error, %Ecto.Changeset{}} = RouteManagement.update_area(area, @invalid_attrs)
      assert area == RouteManagement.get_area!(area.id)
    end

    test "delete_area/1 deletes the area" do
      area = area_fixture()
      assert {:ok, %Area{}} = RouteManagement.delete_area(area)
      assert_raise Ecto.NoResultsError, fn -> RouteManagement.get_area!(area.id) end
    end

    test "change_area/1 returns a area changeset" do
      area = area_fixture()
      assert %Ecto.Changeset{} = RouteManagement.change_area(area)
    end
  end

  describe "gyms" do
    alias GymRat.Facilities.Gym

    @valid_attrs %{address: "some address", name: "some name", website: "some website"}
    @update_attrs %{address: "some updated address", name: "some updated name", website: "some updated website"}
    @invalid_attrs %{address: nil, name: nil, website: nil}

    def gym_fixture(attrs \\ %{}) do
      {:ok, gym} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Facilities.create_gym()

      gym
    end

    test "list_gyms/0 returns all gyms" do
      gym = gym_fixture()
      assert Facilities.list_gyms() == [gym]
    end

    test "get_gym!/1 returns the gym with given id" do
      gym = gym_fixture()
      assert Facilities.get_gym!(gym.id) == gym
    end

    test "create_gym/1 with valid data creates a gym" do
      assert {:ok, %Gym{} = gym} = Facilities.create_gym(@valid_attrs)
      assert gym.address == "some address"
      assert gym.name == "some name"
      assert gym.website == "some website"
    end

    test "create_gym/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Facilities.create_gym(@invalid_attrs)
    end

    test "update_gym/2 with valid data updates the gym" do
      gym = gym_fixture()
      assert {:ok, gym} = Facilities.update_gym(gym, @update_attrs)
      assert %Gym{} = gym
      assert gym.address == "some updated address"
      assert gym.name == "some updated name"
      assert gym.website == "some updated website"
    end

    test "update_gym/2 with invalid data returns error changeset" do
      gym = gym_fixture()
      assert {:error, %Ecto.Changeset{}} = Facilities.update_gym(gym, @invalid_attrs)
      assert gym == Facilities.get_gym!(gym.id)
    end

    test "delete_gym/1 deletes the gym" do
      gym = gym_fixture()
      assert {:ok, %Gym{}} = Facilities.delete_gym(gym)
      assert_raise Ecto.NoResultsError, fn -> Facilities.get_gym!(gym.id) end
    end

    test "change_gym/1 returns a gym changeset" do
      gym = gym_fixture()
      assert %Ecto.Changeset{} = Facilities.change_gym(gym)
    end
  end
end
