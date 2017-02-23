defmodule Checklist.CheckTest do
  use Checklist.ModelCase

  alias Checklist.Check

  @valid_attrs %{description: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Check.changeset(%Check{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Check.changeset(%Check{}, @invalid_attrs)
    refute changeset.valid?
  end
end
