defmodule TasksWeb.UserController do
  use TasksWeb, :controller

  alias Tasks.Accounts
  alias Tasks.Accounts.User

  #Taken from Nat Tuck's lecture notes
  def index(conn, _params) do
    current_user = conn.assigns[:current_user]
    users = Accounts.list_users()
    follows = Tasks.Todo.follows_map_for(current_user.id)
    render(conn, "index.html", users: users, follows: follows)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    managees = Tasks.Todo.managees_by_user(user)
               |> Enum.map(fn x -> elem(x, 0) end)
    managers = Tasks.Todo.managers_by_user(user)
               |> Enum.map(fn x -> elem(x, 0) end)
    render(conn, "show.html", user: user, managees: managees, managers: managers)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
