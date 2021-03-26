defmodule MyheroacademyapiWeb.QuirckView do
  use MyheroacademyapiWeb, :view
  alias MyheroacademyapiWeb.QuirckView

  def render("index.json", %{quircks: quircks}) do
    %{data: render_many(quircks, QuirckView, "quirck.json")}
  end

  def render("show.json", %{quirck: quirck}) do
    %{data: render_one(quirck, QuirckView, "quirck.json")}
  end

  def render("quirck.json", %{quirck: quirck}) do
    %{id: quirck.id,
      name: quirck.name,
      description: quirck.description,
      hero_id: quirck.hero_id
    }
  end
end
