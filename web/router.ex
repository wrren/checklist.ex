defmodule Checklist.Router do
  use Checklist.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Checklist.Plug.Authenticate
  end

  pipeline :auth do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Checklist do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/lists", ListController do
      resources "/uses",    ListUseController, as: :use
      resources "/checks",  CheckController
    end
  end

  scope "/auth", Checklist do
    pipe_through :auth # Use the default browser stack

    get   "/:provider",           AuthController, :request
    get   "/:provider/callback",  AuthController, :callback
    post  "/:provider/callback",  AuthController, :callback

  end

  # Other scopes may use custom stacks.
  # scope "/api", Checklist do
  #   pipe_through :api
  # end
end
