defmodule Checklist.ListUse do
  use Checklist.Web, :model

  @min_name_length 5

  schema "list_uses" do
    field :name, :string
    belongs_to :list, Checklist.List

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :list_id])
    |> validate_required([:name])
    |> validate_length(:name, min: @min_name_length)
  end
end
