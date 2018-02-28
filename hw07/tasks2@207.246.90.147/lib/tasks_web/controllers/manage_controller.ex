defmodule TasksWeb.ManageController do
  use TasksWeb, :controller

  alias Tasks.Todo
  alias Tasks.Todo.Manage

  action_fallback TasksWeb.FallbackController

  def index(conn, _params) do
    manager = Todo.list_manager()
    render(conn, "index.json", manager: manager)
  end

  def create(conn, %{"manage" => manage_params}) do
    with {:ok, %Manage{} = manage} <- Todo.create_manage(manage_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", manage_path(conn, :show, manage))
      |> render("show.json", manage: manage)
    end
  end

  def show(conn, %{"id" => id}) do
    manage = Todo.get_manage!(id)
    render(conn, "show.json", manage: manage)
  end

  def update(conn, %{"id" => id, "manage" => manage_params}) do
    manage = Todo.get_manage!(id)

    with {:ok, %Manage{} = manage} <- Todo.update_manage(manage, manage_params) do
      render(conn, "show.json", manage: manage)
    end
  end

  def delete(conn, %{"id" => id}) do
    manage = Todo.get_manage!(id)
    with {:ok, %Manage{}} <- Todo.delete_manage(manage) do
      send_resp(conn, :no_content, "")
    end
  end
end
