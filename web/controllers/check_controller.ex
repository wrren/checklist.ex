defmodule Checklist.CheckController do
  use Checklist.Web, :controller

  alias Checklist.{List, Check}
  import Ecto.Changeset

  def index(conn, %{"list_id" => list_id}) do
    list = Repo.get! List, list_id
    checks = Repo.all(Check)
    render(conn, "index.html", list: list, checks: checks)
  end

  def new(conn, %{"list_id" => list_id}) do
    list = Repo.get! List, list_id
    changeset = Check.changeset(%Check{})
    render(conn, "new.html", list: list, changeset: changeset)
  end

  def create(conn, %{"list_id" => list_id, "check" => check_params}) do
    list = Repo.get!(List, list_id)
    changeset = Check.changeset(%Check{}, check_params)
                |> put_assoc(:list, list)

    case Repo.insert(changeset) do
      {:ok, _check} ->
        conn
        |> put_flash(:info, "Check created successfully.")
        |> redirect(to: list_check_path(conn, :index, list_id))
      {:error, changeset} ->
        render(conn, "new.html", list: list, changeset: changeset)
    end
  end

  def show(conn, %{"list_id" => list_id, "id" => id}) do
    list = Repo.get!(List, list_id)
    check = Repo.get!(Check, id)
    render(conn, "show.html", list: list, check: check)
  end

  def edit(conn, %{"list_id" => list_id, "id" => id}) do
    list = Repo.get!(List, list_id)
    check = Repo.get!(Check, id)
    changeset = Check.changeset(check)
    render(conn, "edit.html", list: list, check: check, changeset: changeset)
  end

  def update(conn, %{"list_id" => list_id, "id" => id, "check" => check_params}) do
    list = Repo.get!(List, list_id)
    check = Repo.get!(Check, id)
    changeset = Check.edit_changeset(check, conn.assigns[:user], check_params)

    case Repo.update(changeset) do
      {:ok, check} ->
        conn
        |> put_flash(:info, "Check updated successfully.")
        |> redirect(to: list_check_path(conn, :show, list_id, check))
      {:error, changeset} ->
        render(conn, "edit.html", list: list, check: check, changeset: changeset)
    end
  end

  def delete(conn, %{"list_id" => list_id, "id" => id}) do
    check = Repo.get!(Check, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(check)

    conn
    |> put_flash(:info, "Check deleted successfully.")
    |> redirect(to: list_check_path(conn, :index, list_id))
  end
end
