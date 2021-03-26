defmodule Myheroacademyapi.Repo.Migrations.CreateQuircks do
  use Ecto.Migration

  def change do
    create table(:quircks) do
      add :name, :string
      add :description, :string
      add :hero_id, references(:heros, on_delete: :nothing)

      timestamps()
    end

    create index(:quircks, [:hero_id])
  end
end
