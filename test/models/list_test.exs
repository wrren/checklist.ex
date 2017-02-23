defmodule Checklist.ListTest do
  use Checklist.ModelCase

  alias Checklist.List

  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = List.changeset(%List{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = List.changeset(%List{}, @invalid_attrs)
    refute changeset.valid?
  end
end
