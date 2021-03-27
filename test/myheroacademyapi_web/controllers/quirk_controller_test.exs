defmodule MyheroacademyapiWeb.QuirkControllerTest do
  use MyheroacademyapiWeb.ConnCase

  alias Myheroacademyapi.Quirks
  alias Myheroacademyapi.Quirks.Quirk

  @create_attrs %{
    description: "some description",
    name: "some name"
  }
  @update_attrs %{
    description: "some updated description",
    name: "some updated name"
  }
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:quirk) do
    {:ok, quirk} = Quirks.create_quirk(@create_attrs)
    quirk
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all quirks", %{conn: conn} do
      conn = get(conn, Routes.quirk_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create quirk" do
    test "renders quirk when data is valid", %{conn: conn} do
      conn = post(conn, Routes.quirk_path(conn, :create), quirk: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.quirk_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.quirk_path(conn, :create), quirk: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update quirk" do
    setup [:create_quirk]

    test "renders quirk when data is valid", %{conn: conn, quirk: %Quirk{id: id} = quirk} do
      conn = put(conn, Routes.quirk_path(conn, :update, quirk), quirk: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.quirk_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, quirk: quirk} do
      conn = put(conn, Routes.quirk_path(conn, :update, quirk), quirk: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete quirk" do
    setup [:create_quirk]

    test "deletes chosen quirk", %{conn: conn, quirk: quirk} do
      conn = delete(conn, Routes.quirk_path(conn, :delete, quirk))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.quirk_path(conn, :show, quirk))
      end
    end
  end

  defp create_quirk(_) do
    quirk = fixture(:quirk)
    {:ok, quirk: quirk}
  end
end
