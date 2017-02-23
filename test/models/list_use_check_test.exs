defmodule Checklist.ListUseCheckTest do
  use Checklist.ModelCase

  alias Checklist.ListUseCheck

  @valid_attrs %{is_checked: true}
  
  test "changeset with valid attributes" do
    changeset = ListUseCheck.changeset(%ListUseCheck{}, @valid_attrs)
    assert changeset.valid?
  end
end
