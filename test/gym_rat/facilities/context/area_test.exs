defmodule GymRat.Facilities.Context.AreaTest do
  use GymRat.DataCase

  import GymRat.TestFactories

  alias GymRat.Facilities

  describe "areas" do
    alias GymRat.Facilities.Area

    @update_attrs %{gym_id: 43, name: "some updated name", order: 43}
    @invalid_attrs %{gym_id: nil, name: nil, order: nil}

    test "list_areas/0 returns all areas" do
      expected_area = insert(:area)
      area = Facilities.get_area!(expected_area.id)
      assert Facilities.list_areas() == [area]
    end

    test "get_area!/1 returns the area with given id" do
      expected_area = insert(:area)
      area = Facilities.get_area!(expected_area.id)
      assert area.gym_id == expected_area.gym_id
      assert area.name == expected_area.name
      assert area.order == expected_area.order
    end

    test "create_area/1 with valid data creates a area" do
      expected_area = params_with_assocs(:area)
      assert {:ok, %Area{} = area} = Facilities.create_area(expected_area)
      assert area.gym_id == expected_area.gym_id
      assert area.name == expected_area.name
      assert area.order == expected_area.order
    end

    test "create_area/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Facilities.create_area(@invalid_attrs)
    end

    test "update_area/2 with valid data updates the area" do
      gym = insert(:gym)
      area = insert(:area)
      assert {:ok, area} = Facilities.update_area(area, %{@update_attrs | gym_id: gym.id})
      assert %Area{} = area
      assert area.gym_id == gym.id
      assert area.name == "some updated name"
      assert area.order == 43
    end

    test "update_area/2 with invalid data returns error changeset" do
      area = insert(:area)
      area_before_update = Facilities.get_area!(area.id)
      assert {:error, %Ecto.Changeset{}} = Facilities.update_area(area, @invalid_attrs)
      assert area_before_update == Facilities.get_area!(area.id)
    end

    test "delete_area/1 deletes the area" do
      area = insert(:area)
      assert {:ok, %Area{}} = Facilities.delete_area(area)
      assert_raise Ecto.NoResultsError, fn -> Facilities.get_area!(area.id) end
    end

    test "change_area/1 returns a area changeset" do
      area = insert(:area)
      assert %Ecto.Changeset{} = Facilities.change_area(area)
    end
  end
end
