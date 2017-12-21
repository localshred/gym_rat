defmodule GymRat.InventoryTest do
  use GymRat.DataCase

  import GymRat.TestFactories

  alias GymRat.Inventory

  describe "holds" do
    alias GymRat.Inventory.Hold

    @update_attrs %{color: "some updated color", count: 43, features: "some updated features", maker: "some updated maker", material: "some updated material", primary_use: "some updated primary_use", size: "some updated size"}
    @invalid_attrs %{color: nil, count: nil, features: nil, maker: nil, material: nil, primary_use: nil, size: nil}

    test "list_holds/0 returns all holds" do
      hold = insert(:hold)
      assert Inventory.list_holds() == [hold]
    end

    test "get_hold!/1 returns the hold with given id" do
      hold = insert(:hold)
      assert Inventory.get_hold!(hold.id) == hold
    end

    test "create_hold/1 with valid data creates a hold" do
      expected_hold = params_for(:hold)
      assert {:ok, %Hold{} = hold} = Inventory.create_hold(expected_hold)
      assert hold.color == expected_hold.color
      assert hold.count == expected_hold.count
      assert hold.features == expected_hold.features
      assert hold.maker == expected_hold.maker
      assert hold.material == expected_hold.material
      assert hold.primary_use == expected_hold.primary_use
      assert hold.size == expected_hold.size
    end

    test "create_hold/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_hold(@invalid_attrs)
    end

    test "update_hold/2 with valid data updates the hold" do
      hold = insert(:hold)
      assert {:ok, hold} = Inventory.update_hold(hold, @update_attrs)
      assert %Hold{} = hold
      assert hold.color == "some updated color"
      assert hold.count == 43
      assert hold.features == "some updated features"
      assert hold.maker == "some updated maker"
      assert hold.material == "some updated material"
      assert hold.primary_use == "some updated primary_use"
      assert hold.size == "some updated size"
    end

    test "update_hold/2 with invalid data returns error changeset" do
      hold = insert(:hold)
      assert {:error, %Ecto.Changeset{}} = Inventory.update_hold(hold, @invalid_attrs)
      assert hold == Inventory.get_hold!(hold.id)
    end

    test "delete_hold/1 deletes the hold" do
      hold = insert(:hold)
      assert {:ok, %Hold{}} = Inventory.delete_hold(hold)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_hold!(hold.id) end
    end

    test "change_hold/1 returns a hold changeset" do
      hold = insert(:hold)
      assert %Ecto.Changeset{} = Inventory.change_hold(hold)
    end
  end
end

