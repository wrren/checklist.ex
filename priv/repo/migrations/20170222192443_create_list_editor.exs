defmodule Checklist.Repo.Migrations.CreateListEditor do
  use Ecto.Migration

  def change do
    create table(:list_editors) do
      add :is_owner, :boolean, default: false, null: false
      add :list_id, references(:lists, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end
    create index(:list_editors, [:list_id])
    create index(:list_editors, [:user_id])
    create unique_index(:list_editors, [:list_id, :user_id])
  end
end
