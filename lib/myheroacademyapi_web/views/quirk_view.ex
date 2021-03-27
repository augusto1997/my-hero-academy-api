defmodule MyheroacademyapiWeb.QuirkView do
  use MyheroacademyapiWeb, :view
  alias MyheroacademyapiWeb.QuirkView

  def render("index.json", %{quirks: quirks}) do
    %{data: render_many(quirks, QuirkView, "quirk.json")}
  end

  def render("show.json", %{quirk: quirk}) do
    %{data: render_one(quirk, QuirkView, "quirk.json")}
  end

  def render("quirk.json", %{quirk: quirk}) do
    %{ id: quirk.id, name: quirk.name, description: quirk.description, hero_id: quirk.hero_id }
  end
end
