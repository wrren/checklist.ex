defmodule Checklist.PageController do
  use Checklist.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
