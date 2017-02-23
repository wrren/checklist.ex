defmodule Checklist.ListUseTest do
  use Checklist.ModelCase

  alias Checklist.ListUse

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ListUse.changeset(%ListUse{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ListUse.changeset(%ListUse{}, @invalid_attrs)
    refute changeset.valid?
  end
end
