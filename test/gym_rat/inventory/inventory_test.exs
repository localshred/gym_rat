defmodule GymRat.InventoryTest do
  use GymRat.DataCase

  alias GymRat.Inventory

  describe "holds" do
    alias GymRat.Inventory.Hold

    @valid_attrs %{color: "some color", count: 42, features: "some features", maker: "some maker", material: "some material", primary_use: "some primary_use", size: "some size"}
    @update_attrs %{color: "some updated color", count: 43, features: "some updated features", maker: "some updated maker", material: "some updated material", primary_use: "some updated primary_use", size: "some updated size"}
    @invalid_attrs %{color: nil, count: nil, features: nil, maker: nil, material: nil, primary_use: nil, size: nil}

    def hold_fixture(attrs \\ %{}) do
      {:ok, hold} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Inventory.create_hold()

      hold
    end

    test "list_holds/0 returns all holds" do
      hold = hold_fixture()
      assert Inventory.list_holds() == [hold]
    end

    test "get_hold!/1 returns the hold with given id" do
      hold = hold_fixture()
      assert Inventory.get_hold!(hold.id) == hold
    end

    test "create_hold/1 with valid data creates a hold" do
      assert {:ok, %Hold{} = hold} = Inventory.create_hold(@valid_attrs)
      assert hold.color == "some color"
      assert hold.count == 42
      assert hold.features == "some features"
      assert hold.maker == "some maker"
      assert hold.material == "some material"
      assert hold.primary_use == "some primary_use"
      assert hold.size == "some size"
    end

    test "create_hold/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_hold(@invalid_attrs)
    end

    test "update_hold/2 with valid data updates the hold" do
      hold = hold_fixture()
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
      hold = hold_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_hold(hold, @invalid_attrs)
      assert hold == Inventory.get_hold!(hold.id)
    end

    test "delete_hold/1 deletes the hold" do
      hold = hold_fixture()
      assert {:ok, %Hold{}} = Inventory.delete_hold(hold)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_hold!(hold.id) end
    end

    test "change_hold/1 returns a hold changeset" do
      hold = hold_fixture()
      assert %Ecto.Changeset{} = Inventory.change_hold(hold)
    end
  end
end

