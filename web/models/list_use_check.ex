defmodule Checklist.ListUseCheck do
  use Checklist.Web, :model

  schema "list_use_checks" do
    field :is_checked, :boolean, default: false
    belongs_to :list_use, Checklist.ListUse
    belongs_to :check, Checklist.Check

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:is_checked])
    |> validate_required([:is_checked])
  end
end
