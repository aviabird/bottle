defmodule HawkeyeWeb.Router do
  use HawkeyeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HawkeyeWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    #get "/actions/:id", ActionController, :show
    resources "actions", ActionController

    resources "items", ItemController

    # put "/actions/:id", ActionController, :update
    # get "/action", CreateactionController, :new 
    # post "/action", CreateactionController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", HawkeyeWeb do
  #   pipe_through :api
  # end
end
