defmodule MyheroacademyapiWeb.HeroController do
  use MyheroacademyapiWeb, :controller
  use PhoenixSwagger

  alias Myheroacademyapi.Heros
  alias Myheroacademyapi.Heros.Hero

  action_fallback MyheroacademyapiWeb.FallbackController

  def swagger_definitions do
    %{
      Hero:
        swagger_schema do
          title("Hero")
          description("A Hero of the application")

          properties do
            id(:integer, "Unique identifier", required: true)
            first_name(:string, "First name", required: true)
            last_name(:string, "Last name", required: true)
            nick_name(:string, "Nick name",  required: true)
          end

          example(%{
            first_name: "Izuku",
            last_name: "Midoriya",
            id: "1",
            nick_name: "Deku"
          })
        end,
      Heros:
        swagger_schema do
          title("Heros")
          description("A collection of Heros")
          type(:array)
          items(Schema.ref(:Hero))
        end
    }
  end

  swagger_path :index do
    get("/api/heros")
    summary("List of Heros")
    description("Returns an List of Heros Entities Records from Database")
    produces("application/json")

    response(200, "OK", Schema.ref(:Heros),
      example: %{
        data: [
          %{
            id: 1,
            first_name: "Izuku",
            last_name: "Midoriya",
            nick_name: "Deku"
          }
        ]
      }
    )
  end

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
