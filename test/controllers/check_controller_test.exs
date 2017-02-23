defmodule Checklist.CheckControllerTest do
  use Checklist.ConnCase

  alias Checklist.{List, Check}
  @valid_attrs %{description: "some content", title: "some content"}
  @invalid_attrs %{title: "", description: ""}

  setup %{conn: conn} do
    list = Repo.insert! List.changeset(%List{}, %{name: "some content", description: "some content"})
    {:ok, conn: conn, list: list}
  end

  test "lists all entries on index", %{conn: conn, list: list} do
    conn = get conn, list_check_path(conn, :index, list)
    assert html_response(conn, 200) =~ "Listing checks"
  end

  test "renders form for new resources", %{conn: conn, list: list} do
    conn = get conn, list_check_path(conn, :new, list)
    assert html_response(conn, 200) =~ "New check"
  end

  test "creates resource and redirects when data is valid", %{conn: conn, list: list} do
    conn = post conn, list_check_path(conn, :create, list), check: @valid_attrs
    assert redirected_to(conn) == list_check_path(conn, :index, list)
    assert Repo.get_by(Check, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn, list: list} do
    conn = post conn, list_check_path(conn, :create, list), check: @invalid_attrs
    assert html_response(conn, 200) =~ "New check"
  end

  test "shows chosen resource", %{conn: conn, list: list} do
    check = Repo.insert! %Check{title: "some content", description: "some content", list_id: list.id}
    conn = get conn, list_check_path(conn, :show, list, check)
    assert html_response(conn, 200) =~ "Show check"
  end

  test "renders page not found when id is nonexistent", %{conn: conn, list: list} do
    assert_error_sent 404, fn ->
      get conn, list_check_path(conn, :show, list, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn, list: list} do
    check = Repo.insert! %Check{title: "some content", description: "some content", list_id: list.id}
    conn = get conn, list_check_path(conn, :edit, list, check)
    assert html_response(conn, 200) =~ "Edit check"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn, list: list} do
    check = Repo.insert! %Check{title: "some content", description: "some content", list_id: list.id}
    conn = put conn, list_check_path(conn, :update, list, check), check: @valid_attrs
    assert redirected_to(conn) == list_check_path(conn, :show, list, check)
    assert Repo.get_by(Check, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, list: list} do
    check = Repo.insert! %Check{title: "some content", description: "some content", list_id: list.id}
    conn = put conn, list_check_path(conn, :update, list, check), check: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit check"
  end

  test "deletes chosen resource", %{conn: conn, list: list} do
    check = Repo.insert! %Check{title: "some content", description: "some content", list_id: list.id}
    conn = delete conn, list_check_path(conn, :delete, list, check)
    assert redirected_to(conn) == list_check_path(conn, :index, list)
    refute Repo.get(Check, check.id)
  end
end
