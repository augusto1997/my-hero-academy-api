defmodule MyheroacademyapiWeb.QuirkController do
  use MyheroacademyapiWeb, :controller

  alias Myheroacademyapi.Quirks
  alias Myheroacademyapi.Quirks.Quirk

  action_fallback MyheroacademyapiWeb.FallbackController

  def index(conn, _params) do
    quirks = Quirks.list_quirks()
    render(conn, "index.json", quirks: quirks)
  end

  def create(conn, %{"quirk" => quirk_params}) do
    with {:ok, %Quirk{} = quirk} <- Quirks.create_quirk(quirk_params) do
      conn
      |> put_status(:created)
      |> render("show.json", quirk: quirk)
    end
  end

  def show(conn, %{"id" => id}) do
    quirk = Quirks.get_quirk!(id)
    render(conn, "show.json", quirk: quirk)
  end

  def update(conn, %{"id" => id, "quirk" => quirk_params}) do
    quirk = Quirks.get_quirk!(id)

    with {:ok, %Quirk{} = quirk} <- Quirks.update_quirk(quirk, quirk_params) do
      render(conn, "show.json", quirk: quirk)
    end
  end

  def delete(conn, %{"id" => id}) do
    quirk = Quirks.get_quirk!(id)

    with {:ok, %Quirk{}} <- Quirks.delete_quirk(quirk) do
      send_resp(conn, :no_content, "")
    end
  end
end
