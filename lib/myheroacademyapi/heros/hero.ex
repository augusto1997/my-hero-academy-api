defmodule Myheroacademyapi.Heros.Hero do
  use Ecto.Schema
  import Ecto.Changeset

  alias Myheroacademyapi.Quirks.Quirk

  schema "heros" do
    field :first_name, :string
    field :last_name, :string
    field :nick_name, :string
    has_one :quirk, Quirk

    timestamps()
  end

  @doc false
  def changeset(hero, attrs) do
    hero
    |> cast(attrs, [:first_name, :last_name, :nick_name])
    |> validate_required([:first_name, :last_name, :nick_name])
  end
end
