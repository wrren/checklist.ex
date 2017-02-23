defmodule Checklist.ListUseControllerTest do
  use Checklist.ConnCase

  alias Checklist.{List, ListUse}
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{name: ""}

  setup %{conn: conn} do
    list = Repo.insert! %List{name: "some content", description: "some content"}
    {:ok, conn: conn, list: list}
  end

  test "lists all entries on index", %{conn: conn, list: list} do
    conn = get conn, list_use_path(conn, :index, list)
    assert html_response(conn, 200) =~ "Listing list uses"
  end

  test "renders form for new resources", %{conn: conn, list: list} do
    conn = get conn, list_use_path(conn, :new, list)
    assert html_response(conn, 200) =~ "New list use"
  end

  test "creates resource and redirects when data is valid", %{conn: conn, list: list} do
    conn = post conn, list_use_path(conn, :create, list), list_use: @valid_attrs
    assert redirected_to(conn) == list_use_path(conn, :index, list)
    assert Repo.get_by(ListUse, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn, list: list} do
    conn = post conn, list_use_path(conn, :create, list), list_use: @invalid_attrs
    assert html_response(conn, 200) =~ "New list use"
  end

  test "shows chosen resource", %{conn: conn, list: list} do
    list_use = Repo.insert! %ListUse{name: "some content", list_id: list.id}
    conn = get conn, list_use_path(conn, :show, list, list_use)
    assert html_response(conn, 200) =~ "Show list use"
  end

  test "renders page not found when id is nonexistent", %{conn: conn, list: list} do
    assert_error_sent 404, fn ->
      get conn, list_use_path(conn, :show, list, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn, list: list} do
    list_use = Repo.insert! %ListUse{name: "some content", list_id: list.id}
    conn = get conn, list_use_path(conn, :edit, list, list_use)
    assert html_response(conn, 200) =~ "Edit list use"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn, list: list} do
    list_use = Repo.insert! %ListUse{name: "some content", list_id: list.id}
    conn = put conn, list_use_path(conn, :update, list, list_use), list_use: @valid_attrs
    assert redirected_to(conn) == list_use_path(conn, :show, list, list_use)
    assert Repo.get_by(ListUse, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, list: list} do
    list_use = Repo.insert! %ListUse{name: "some content", list_id: list.id}
    conn = put conn, list_use_path(conn, :update, list, list_use), list_use: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit list use"
  end

  test "deletes chosen resource", %{conn: conn, list: list} do
    list_use = Repo.insert! %ListUse{name: "some content", list_id: list.id}
    conn = delete conn, list_use_path(conn, :delete, list, list_use)
    assert redirected_to(conn) == list_use_path(conn, :index, list)
    refute Repo.get(ListUse, list_use.id)
  end
end
