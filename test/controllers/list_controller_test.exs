defmodule Checklist.ListControllerTest do
  use Checklist.ConnCase

  alias Checklist.List
  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{name: ""}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, list_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing lists"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, list_path(conn, :new)
    assert html_response(conn, 200) =~ "New list"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, list_path(conn, :create), list: @valid_attrs
    assert redirected_to(conn) == list_path(conn, :index)
    assert Repo.get_by(List, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, list_path(conn, :create), list: @invalid_attrs
    assert html_response(conn, 200) =~ "New list"
  end

  test "shows chosen resource", %{conn: conn} do
    list = Repo.insert! %List{name: "some content", description: "some content"}
    conn = get conn, list_path(conn, :show, list)
    assert html_response(conn, 200) =~ "Show list"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, list_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    list = Repo.insert! %List{name: "some content", description: "some content"}
    conn = get conn, list_path(conn, :edit, list)
    assert html_response(conn, 200) =~ "Edit list"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    list = Repo.insert! %List{name: "some content", description: "some content"}
    conn = put conn, list_path(conn, :update, list), list: @valid_attrs
    assert redirected_to(conn) == list_path(conn, :show, list)
    assert Repo.get_by(List, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    list = Repo.insert! %List{name: "some content", description: "some content"}
    conn = put conn, list_path(conn, :update, list), list: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit list"
  end

  test "deletes chosen resource", %{conn: conn} do
    list = Repo.insert! %List{name: "some content", description: "some content"}
    conn = delete conn, list_path(conn, :delete, list)
    assert redirected_to(conn) == list_path(conn, :index)
    refute Repo.get(List, list.id)
  end
end
