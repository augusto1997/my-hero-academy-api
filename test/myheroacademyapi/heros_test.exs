defmodule Myheroacademyapi.HerosTest do
  use Myheroacademyapi.DataCase

  alias Myheroacademyapi.Heros

  describe "heros" do
    alias Myheroacademyapi.Heros.Hero

    @valid_attrs %{first_name: "some first_name", last_name: "some last_name", nick_name: "some nick_name"}
    @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name", nick_name: "some updated nick_name"}
    @invalid_attrs %{first_name: nil, last_name: nil, nick_name: nil}

    def hero_fixture(attrs \\ %{}) do
      {:ok, hero} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Heros.create_hero()

      hero
    end

    test "list_heros/0 returns all heros" do
      hero = hero_fixture()
      assert Heros.list_heros() == [hero]
    end

    test "get_hero!/1 returns the hero with given id" do
      hero = hero_fixture()
      assert Heros.get_hero!(hero.id) == hero
    end

    test "create_hero/1 with valid data creates a hero" do
      assert {:ok, %Hero{} = hero} = Heros.create_hero(@valid_attrs)
      assert hero.first_name == "some first_name"
      assert hero.last_name == "some last_name"
      assert hero.nick_name == "some nick_name"
    end

    test "create_hero/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Heros.create_hero(@invalid_attrs)
    end

    test "update_hero/2 with valid data updates the hero" do
      hero = hero_fixture()
      assert {:ok, %Hero{} = hero} = Heros.update_hero(hero, @update_attrs)
      assert hero.first_name == "some updated first_name"
      assert hero.last_name == "some updated last_name"
      assert hero.nick_name == "some updated nick_name"
    end

    test "update_hero/2 with invalid data returns error changeset" do
      hero = hero_fixture()
      assert {:error, %Ecto.Changeset{}} = Heros.update_hero(hero, @invalid_attrs)
      assert hero == Heros.get_hero!(hero.id)
    end

    test "delete_hero/1 deletes the hero" do
      hero = hero_fixture()
      assert {:ok, %Hero{}} = Heros.delete_hero(hero)
      assert_raise Ecto.NoResultsError, fn -> Heros.get_hero!(hero.id) end
    end

    test "change_hero/1 returns a hero changeset" do
      hero = hero_fixture()
      assert %Ecto.Changeset{} = Heros.change_hero(hero)
    end
  end
end
