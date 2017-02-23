defmodule Checklist.Repo.Migrations.CreateListUse do
  use Ecto.Migration

  def change do
    create table(:list_uses) do
      add :name, :string, null: false
      add :list_id, references(:lists, on_delete: :delete_all), null: false

      timestamps()
    end
    create index(:list_uses, [:list_id])
  end
end
