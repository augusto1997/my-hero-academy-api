defmodule MyheroacademyapiWeb.QuirckController do
  use MyheroacademyapiWeb, :controller

  alias Myheroacademyapi.Quircks
  alias Myheroacademyapi.Quircks.Quirck

  action_fallback MyheroacademyapiWeb.FallbackController

  def index(conn, _params) do
    quircks = Quircks.list_quircks()
    render(conn, "index.json", quircks: quircks)
  end

  def create(conn, %{"quirck" => quirck_params}) do
    with {:ok, %Quirck{} = quirck} <- Quircks.create_quirck(quirck_params) do
      conn
      |> put_status(:created)
      |> render("show.json", quirck: quirck)
    end
  end

  def show(conn, %{"id" => id}) do
    quirck = Quircks.get_quirck!(id)
    render(conn, "show.json", quirck: quirck)
  end

  def update(conn, %{"id" => id, "quirck" => quirck_params}) do
    quirck = Quircks.get_quirck!(id)

    with {:ok, %Quirck{} = quirck} <- Quircks.update_quirck(quirck, quirck_params) do
      render(conn, "show.json", quirck: quirck)
    end
  end

  def delete(conn, %{"id" => id}) do
    quirck = Quircks.get_quirck!(id)

    with {:ok, %Quirck{}} <- Quircks.delete_quirck(quirck) do
      send_resp(conn, :no_content, "")
    end
  end
end
