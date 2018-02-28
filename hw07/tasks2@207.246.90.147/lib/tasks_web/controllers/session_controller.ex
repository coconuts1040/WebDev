#Taken from Nat Tuck's lecture notes
defmodule TasksWeb.SessionController do
  use TasksWeb, :controller

  alias Tasks.Accounts

  def create(conn, %{"email" => email}) do
    user = Accounts.get_user_via_email(email)
    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Logged in as #{user.name}")
      |> redirect(to: "/tasks")
    else
      conn
      |> put_flash(:error, "Incorrect login")
      |> redirect(to: page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out")
    |> redirect(to: page_path(conn, :index))
  end
end
