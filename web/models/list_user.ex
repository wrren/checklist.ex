defmodule Checklist.ListUser do
  use Checklist.Web, :model

  schema "list_users" do
    belongs_to :list_use, Checklist.ListUse
    belongs_to :user, Checklist.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :list_use_id])
    |> validate_required([])
    |> foreign_key_constraint(:list_use_id)
    |> foreign_key_constraint(:user_id)
  end
end
