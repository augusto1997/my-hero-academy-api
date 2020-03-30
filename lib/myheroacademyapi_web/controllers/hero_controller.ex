defmodule MyheroacademyapiWeb.HeroController do
  use MyheroacademyapiWeb, :controller

  alias Myheroacademyapi.Heros
  alias Myheroacademyapi.Heros.Hero

  action_fallback MyheroacademyapiWeb.FallbackController

  def index(conn, _params) do
    heros = Heros.list_heros()
    render(conn, "index.json", heros: heros)
  end

  def create(conn, %{"hero" => hero_params}) do
    with {:ok, %Hero{} = hero} <- Heros.create_hero(hero_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.hero_path(conn, :show, hero))
      |> render("show.json", hero: hero)
    end
  end

  def show(conn, %{"id" => id}) do
    hero = Heros.get_hero!(id)
    render(conn, "show.json", hero: hero)
  end

  def update(conn, %{"id" => id, "hero" => hero_params}) do
    hero = Heros.get_hero!(id)

    with {:ok, %Hero{} = hero} <- Heros.update_hero(hero, hero_params) do
      render(conn, "show.json", hero: hero)
    end
  end

  def delete(conn, %{"id" => id}) do
    hero = Heros.get_hero!(id)

    with {:ok, %Hero{}} <- Heros.delete_hero(hero) do
      send_resp(conn, :no_content, "")
    end
  end
end
