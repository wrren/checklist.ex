defmodule Checklist.ListUseController do
  use Checklist.Web, :controller

  alias Checklist.{List, ListUse}
  import Ecto.Changeset

  def index(conn, %{"list_id" => list_id}) do
    list = Repo.get!(List, list_id)
    list_uses = Repo.all(ListUse)
    render(conn, "index.html", list: list, list_uses: list_uses)
  end

  def new(conn, %{"list_id" => list_id}) do
    list = Repo.get!(List, list_id)
    changeset = ListUse.changeset(%ListUse{}, %{list_id: list_id})
    render(conn, "new.html", list: list, changeset: changeset)
  end

  def create(conn, %{"list_id" => list_id, "list_use" => list_use_params}) do
    list = Repo.get!(List, list_id)
    changeset = ListUse.changeset(%ListUse{}, list_use_params)
                |> put_assoc(:list, list)

    case Repo.insert(changeset) do
      {:ok, _list_use} ->
        conn
        |> put_flash(:info, "List use created successfully.")
        |> redirect(to: list_use_path(conn, :index, list_id))
      {:error, changeset} ->
        render(conn, "new.html", list: list, changeset: changeset)
    end
  end

  def show(conn, %{"list_id" => list_id, "id" => id}) do
    list = Repo.get!(List, list_id)
    list_use = Repo.get!(ListUse, id)
    render(conn, "show.html", list: list, list_use: list_use)
  end

  def edit(conn, %{"list_id" => list_id, "id" => id}) do
    list = Repo.get!(List, list_id)
    list_use = Repo.get!(ListUse, id)
    changeset = ListUse.changeset(list_use)
    render(conn, "edit.html", list: list, list_use: list_use, changeset: changeset)
  end

  def update(conn, %{"list_id" => list_id, "id" => id, "list_use" => list_use_params}) do
    list = Repo.get!(List, list_id)
    list_use = Repo.get!(ListUse, id)
    changeset = ListUse.changeset(list_use, list_use_params)

    case Repo.update(changeset) do
      {:ok, list_use} ->
        conn
        |> put_flash(:info, "List use updated successfully.")
        |> redirect(to: list_use_path(conn, :show, list_id, list_use))
      {:error, changeset} ->
        render(conn, "edit.html", list: list, list_use: list_use, changeset: changeset)
    end
  end

  def delete(conn, %{"list_id" => list_id, "id" => id}) do
    list_use = Repo.get!(ListUse, id)
    
    case Repo.get_by ListUser, user_id: conn.assigns[:user].id, list_use_id: list_use.id do
      nil ->
        conn
        |> put_status(403)
        |> render(Checklist.ErrorView, "403.html")
      _ ->
        Repo.delete!(list_use)
        conn
        |> put_flash(:info, "List use deleted successfully.")
        |> redirect(to: list_use_path(conn, :index, list_id))
    end
  end
end
