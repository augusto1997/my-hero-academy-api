defmodule MyheroacademyapiWeb.HeroControllerTest do
  use MyheroacademyapiWeb.ConnCase

  alias Myheroacademyapi.Heros
  alias Myheroacademyapi.Heros.Hero

  @create_attrs %{
    first_name: "some first_name",
    last_name: "some last_name",
    nick_name: "some nick_name"
  }
  @update_attrs %{
    first_name: "some updated first_name",
    last_name: "some updated last_name",
    nick_name: "some updated nick_name"
  }
  @invalid_attrs %{first_name: nil, last_name: nil, nick_name: nil}

  def fixture(:hero) do
    {:ok, hero} = Heros.create_hero(@create_attrs)
    hero
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all heros", %{conn: conn} do
      conn = get(conn, Routes.hero_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create hero" do
    test "renders hero when data is valid", %{conn: conn} do
      conn = post(conn, Routes.hero_path(conn, :create), hero: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.hero_path(conn, :show, id))

      assert %{
               "id" => id,
               "first_name" => "some first_name",
               "last_name" => "some last_name",
               "nick_name" => "some nick_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.hero_path(conn, :create), hero: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update hero" do
    setup [:create_hero]

    test "renders hero when data is valid", %{conn: conn, hero: %Hero{id: id} = hero} do
      conn = put(conn, Routes.hero_path(conn, :update, hero), hero: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.hero_path(conn, :show, id))

      assert %{
               "id" => id,
               "first_name" => "some updated first_name",
               "last_name" => "some updated last_name",
               "nick_name" => "some updated nick_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, hero: hero} do
      conn = put(conn, Routes.hero_path(conn, :update, hero), hero: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete hero" do
    setup [:create_hero]

    test "deletes chosen hero", %{conn: conn, hero: hero} do
      conn = delete(conn, Routes.hero_path(conn, :delete, hero))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.hero_path(conn, :show, hero))
      end
    end
  end

  defp create_hero(_) do
    hero = fixture(:hero)
    {:ok, hero: hero}
  end
end
