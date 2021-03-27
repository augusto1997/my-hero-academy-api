defmodule Myheroacademyapi.Repo.Migrations.CreateQuirks do
  use Ecto.Migration

  def change do
    create table(:quirks) do
      add :name, :string
      add :description, :string
      add :hero_id, references(:heros, on_delete: :nothing)

      timestamps()
    end

    create index(:quirks, [:hero_id])
  end
end
