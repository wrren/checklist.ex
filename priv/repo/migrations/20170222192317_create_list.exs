defmodule Checklist.Repo.Migrations.CreateList do
  use Ecto.Migration

  def change do
    create table(:lists) do
      add :name, :string, null: false
      add :description, :string, null: false

      timestamps()
    end
    create unique_index(:lists, [:name])

  end
end
