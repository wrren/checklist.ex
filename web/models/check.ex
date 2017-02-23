defmodule Checklist.Check do
  use Checklist.Web, :model

  alias Checklist.{Repo, Check, User, ListUser}

  @min_title_length 5

  schema "checks" do
    field :title, :string
    field :description, :string
    belongs_to :list, Checklist.List

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :list_id])
    |> validate_required([:title, :description])
    |> validate_length(:title, min: @min_title_length)
    |> foreign_key_constraint(:list_id)
  end

  def edit_changeset(struct = %Check{}, user = %User{}, params \\ %{}) do
    struct
    |> changeset(params)
    |> validate_editor(user)
  end

  def validate_editor(changeset, %User{id: user_id}) do
    case Repo.get_by ListUser, list_id: get_field(changeset, :list_id), user_id: user_id do
      nil ->
        changeset |> add_error(:list_id, "User is not set up as an editor for this list")
      _ ->
        changeset
    end
  end
end
