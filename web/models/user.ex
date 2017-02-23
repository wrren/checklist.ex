defmodule Checklist.User do
  use Checklist.Web, :model

  alias Checklist.{Repo, User}

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :first_name, :last_name])
    |> validate_required([:email, :first_name, :last_name])
    |> unique_constraint(:email)
  end

  def find_or_create(email, first_name, last_name) do
    case Repo.get_by(User, email: email) do
      nil   -> Repo.insert(User.changeset(%User{}, %{email: email, first_name: first_name, last_name: last_name}))
      user  -> {:ok, user}
    end
  end
end
