defmodule Checklist.Repo.Migrations.CreateListUser do
  use Ecto.Migration

  def change do
    create table(:list_users) do
      add :list_use_id, references(:list_uses, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end
    create index(:list_users, [:list_use_id])
    create index(:list_users, [:user_id])
    create unique_index(:list_users, [:list_use_id, :user_id])
  end
end
