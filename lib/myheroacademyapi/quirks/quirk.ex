defmodule Myheroacademyapi.Quirks.Quirk do
  use Ecto.Schema
  import Ecto.Changeset

  alias Myheroacademyapi.Heros.Hero

  schema "quirks" do
    field :description, :string
    field :name, :string
    belongs_to :hero, Hero

    timestamps()
  end

  @doc false
  def changeset(quirk, attrs) do
    quirk
    |> cast(attrs, [:name, :description, :hero_id])
    |> validate_required([:name, :description, :hero_id])
    |> assoc_constraint(:hero)
  end
end
