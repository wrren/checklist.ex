defmodule Checklist.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """
  use Checklist.Web, :controller
  plug Ueberauth

  alias Checklist.User

  alias Ueberauth.Strategy.Helpers
  alias Ueberauth.Auth.Info
  alias Ueberauth.Auth

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> render(Checklist.ErrorView, "401.html")
  end

  def callback(%{assigns: %{ueberauth_auth: %Auth{info: %Info{email: email, first_name: first_name, last_name: last_name}}}} = conn, _params) do
    case User.find_or_create(email, first_name, last_name) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Successfully authenticated.")
        |> put_session(:user, user)
        |> redirect(to: "/")
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end
end