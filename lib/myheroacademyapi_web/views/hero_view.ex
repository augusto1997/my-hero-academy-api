defmodule MyheroacademyapiWeb.HeroView do
  use MyheroacademyapiWeb, :view
  alias MyheroacademyapiWeb.HeroView

  def render("index.json", %{heros: heros}) do
    %{data: render_many(heros, HeroView, "hero.json")}
  end

  def render("show.json", %{hero: hero}) do
    %{data: render_one(hero, HeroView, "hero.json")}
  end

  def render("hero.json", %{hero: hero}) do
    %{id: hero.id,
      first_name: hero.first_name,
      last_name: hero.last_name,
      nick_name: hero.nick_name}
  end
end
