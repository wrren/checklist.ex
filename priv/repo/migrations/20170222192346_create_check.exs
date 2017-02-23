defmodule Checklist.Repo.Migrations.CreateCheck do
  use Ecto.Migration

  def change do
    create table(:checks) do
      add :title, :string, null: false
      add :description, :string, null: false
      add :list_id, references(:lists, on_delete: :delete_all), null: false

      timestamps()
    end
    create index(:checks, [:list_id])

  end
end
