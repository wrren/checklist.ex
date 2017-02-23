defmodule Checklist.ListEditor do
  use Checklist.Web, :model

  schema "list_editors" do
    field :is_owner, :boolean, default: false
    belongs_to :list, Checklist.List
    belongs_to :user, Checklist.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:is_owner, :list_id, :user_id])
    |> validate_required([:is_owner])
    |> foreign_key_constraint(:list_id)
    |> foreign_key_constraint(:user_id)
  end
end
