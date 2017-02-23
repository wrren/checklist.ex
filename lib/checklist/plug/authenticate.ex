defmodule Checklist.Plug.Authenticate do
  import Plug.Conn
  import Phoenix.Controller, only: [redirect: 2]

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_session(conn, :user) do
      nil ->
        conn
        |> redirect(to: Checklist.Router.Helpers.auth_path(conn, :request, "saml"))
      user ->
        conn
        |> assign(:user, user)
    end
  end
end