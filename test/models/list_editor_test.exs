defmodule Checklist.ListEditorTest do
  use Checklist.ModelCase

  alias Checklist.ListEditor

  @valid_attrs %{is_owner: true}
  
  test "changeset with valid attributes" do
    changeset = ListEditor.changeset(%ListEditor{}, @valid_attrs)
    assert changeset.valid?
  end
end
