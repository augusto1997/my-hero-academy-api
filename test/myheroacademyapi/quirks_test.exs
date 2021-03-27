defmodule Myheroacademyapi.QuirksTest do
  use Myheroacademyapi.DataCase

  alias Myheroacademyapi.Quirks

  describe "quirks" do
    alias Myheroacademyapi.Quirks.Quirk

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def quirk_fixture(attrs \\ %{}) do
      {:ok, quirk} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Quirks.create_quirk()

      quirk
    end

    test "list_quirks/0 returns all quirks" do
      quirk = quirk_fixture()
      assert Quirks.list_quirks() == [quirk]
    end

    test "get_quirk!/1 returns the quirk with given id" do
      quirk = quirk_fixture()
      assert Quirks.get_quirk!(quirk.id) == quirk
    end

    test "create_quirk/1 with valid data creates a quirk" do
      assert {:ok, %Quirk{} = quirk} = Quirks.create_quirk(@valid_attrs)
      assert quirk.description == "some description"
      assert quirk.name == "some name"
    end

    test "create_quirk/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quirks.create_quirk(@invalid_attrs)
    end

    test "update_quirk/2 with valid data updates the quirk" do
      quirk = quirk_fixture()
      assert {:ok, %Quirk{} = quirk} = Quirks.update_quirk(quirk, @update_attrs)
      assert quirk.description == "some updated description"
      assert quirk.name == "some updated name"
    end

    test "update_quirk/2 with invalid data returns error changeset" do
      quirk = quirk_fixture()
      assert {:error, %Ecto.Changeset{}} = Quirks.update_quirk(quirk, @invalid_attrs)
      assert quirk == Quirks.get_quirk!(quirk.id)
    end

    test "delete_quirk/1 deletes the quirk" do
      quirk = quirk_fixture()
      assert {:ok, %Quirk{}} = Quirks.delete_quirk(quirk)
      assert_raise Ecto.NoResultsError, fn -> Quirks.get_quirk!(quirk.id) end
    end

    test "change_quirk/1 returns a quirk changeset" do
      quirk = quirk_fixture()
      assert %Ecto.Changeset{} = Quirks.change_quirk(quirk)
    end
  end
end
