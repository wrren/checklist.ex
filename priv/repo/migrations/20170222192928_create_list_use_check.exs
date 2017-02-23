defmodule Checklist.Repo.Migrations.CreateListUseCheck do
  use Ecto.Migration

  def change do
    create table(:list_use_checks) do
      add :is_checked, :boolean, default: false, null: false
      add :list_use_id, references(:list_uses, on_delete: :delete_all), null: false
      add :check_id, references(:checks, on_delete: :delete_all), null: false

      timestamps()
    end
    create index(:list_use_checks, [:list_use_id])
    create index(:list_use_checks, [:check_id])
    create unique_index(:list_use_checks, [:list_use_id, :check_id])
  end
end
