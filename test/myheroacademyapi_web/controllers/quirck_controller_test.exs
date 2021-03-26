defmodule MyheroacademyapiWeb.QuirckControllerTest do
  use MyheroacademyapiWeb.ConnCase

  alias Myheroacademyapi.Quircks
  alias Myheroacademyapi.Quircks.Quirck

  @create_attrs %{
    description: "some description",
    name: "some name"
  }
  @update_attrs %{
    description: "some updated description",
    name: "some updated name"
  }
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:quirck) do
    {:ok, quirck} = Quircks.create_quirck(@create_attrs)
    quirck
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all quircks", %{conn: conn} do
      conn = get(conn, Routes.quirck_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create quirck" do
    test "renders quirck when data is valid", %{conn: conn} do
      conn = post(conn, Routes.quirck_path(conn, :create), quirck: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.quirck_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.quirck_path(conn, :create), quirck: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update quirck" do
    setup [:create_quirck]

    test "renders quirck when data is valid", %{conn: conn, quirck: %Quirck{id: id} = quirck} do
      conn = put(conn, Routes.quirck_path(conn, :update, quirck), quirck: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.quirck_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, quirck: quirck} do
      conn = put(conn, Routes.quirck_path(conn, :update, quirck), quirck: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete quirck" do
    setup [:create_quirck]

    test "deletes chosen quirck", %{conn: conn, quirck: quirck} do
      conn = delete(conn, Routes.quirck_path(conn, :delete, quirck))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.quirck_path(conn, :show, quirck))
      end
    end
  end

  defp create_quirck(_) do
    quirck = fixture(:quirck)
    {:ok, quirck: quirck}
  end
end
