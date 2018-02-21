defmodule TasksWeb.Router do
  use TasksWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :get_current_user
    plug :get_users
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  #Taken from Nat Tuck's lecture notes, not sure where it should go
  def get_current_user(conn, _params) do
    user_id = get_session(conn, :user_id)
    if user_id do
      user = Tasks.Accounts.get_user(user_id || -1)
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end

  #Gets the list of users and returns them as two-item tuples
  def get_users(conn, _params) do
    users = Tasks.Accounts.list_users()
            |> Enum.map(fn(x) ->
              { x.name, x.id }
            end)
    assign(conn, :users, users)
  end

  scope "/", TasksWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/feed", PageController, :feed
    resources "/users", UserController
    resources "/tasks", TaskController

    #Taken from Nat Tuck's lecture notes
    post "/session", SessionController, :create
    delete "/session", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", TasksWeb do
  #   pipe_through :api
  # end
end
