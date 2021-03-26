defmodule Myheroacademyapi.Quircks.Quirck do
  use Ecto.Schema
  import Ecto.Changeset

  alias Myheroacademyapi.Heros.Hero

  schema "quircks" do
    field :description, :string
    field :name, :string
    belongs_to :hero, Hero

    timestamps()
  end

  @doc false
  def changeset(quirck, attrs) do
    quirck
    |> cast(attrs, [:name, :description, :hero_id])
    |> validate_required([:name, :description, :hero_id])
    |> assoc_constraint(:hero)
  end
end
