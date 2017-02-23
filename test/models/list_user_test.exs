defmodule Checklist.ListUserTest do
  use Checklist.ModelCase

  alias Checklist.ListUser

  @valid_attrs %{list_id: 1, user_id: 1}

  test "changeset with valid attributes" do
    changeset = ListUser.changeset(%ListUser{}, @valid_attrs)
    assert changeset.valid?
  end
end
