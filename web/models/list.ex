defmodule Checklist.List do
  use Checklist.Web, :model

  alias Checklist.{Repo, User, List, ListUser}

  schema "lists" do
    field :name, :string
    field :description, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description])
    |> validate_required([:name, :description])
    |> unique_constraint(:name)
  end

  def edit_changeset(struct = %List{}, user = %User{}, params \\ %{}) do
    struct
    |> changeset(params)
    |> validate_editor(user)
  end

  def validate_editor(changeset, %User{id: user_id}) do
    case Repo.get_by ListUser, list_id: get_field(changeset, :id), user_id: user_id do
      nil ->
        changeset |> add_error(:id, "User is not set up as an editor for this list")
      _ ->
        changeset
    end
  end
end
