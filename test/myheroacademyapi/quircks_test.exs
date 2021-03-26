defmodule Myheroacademyapi.QuircksTest do
  use Myheroacademyapi.DataCase

  alias Myheroacademyapi.Quircks

  describe "quircks" do
    alias Myheroacademyapi.Quircks.Quirck

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def quirck_fixture(attrs \\ %{}) do
      {:ok, quirck} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Quircks.create_quirck()

      quirck
    end

    test "list_quircks/0 returns all quircks" do
      quirck = quirck_fixture()
      assert Quircks.list_quircks() == [quirck]
    end

    test "get_quirck!/1 returns the quirck with given id" do
      quirck = quirck_fixture()
      assert Quircks.get_quirck!(quirck.id) == quirck
    end

    test "create_quirck/1 with valid data creates a quirck" do
      assert {:ok, %Quirck{} = quirck} = Quircks.create_quirck(@valid_attrs)
      assert quirck.description == "some description"
      assert quirck.name == "some name"
    end

    test "create_quirck/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quircks.create_quirck(@invalid_attrs)
    end

    test "update_quirck/2 with valid data updates the quirck" do
      quirck = quirck_fixture()
      assert {:ok, %Quirck{} = quirck} = Quircks.update_quirck(quirck, @update_attrs)
      assert quirck.description == "some updated description"
      assert quirck.name == "some updated name"
    end

    test "update_quirck/2 with invalid data returns error changeset" do
      quirck = quirck_fixture()
      assert {:error, %Ecto.Changeset{}} = Quircks.update_quirck(quirck, @invalid_attrs)
      assert quirck == Quircks.get_quirck!(quirck.id)
    end

    test "delete_quirck/1 deletes the quirck" do
      quirck = quirck_fixture()
      assert {:ok, %Quirck{}} = Quircks.delete_quirck(quirck)
      assert_raise Ecto.NoResultsError, fn -> Quircks.get_quirck!(quirck.id) end
    end

    test "change_quirck/1 returns a quirck changeset" do
      quirck = quirck_fixture()
      assert %Ecto.Changeset{} = Quircks.change_quirck(quirck)
    end
  end
end
