defmodule Tasks3Web.TaskController do
  use Tasks3Web, :controller

  alias Tasks3.Todo
  alias Tasks3.Todo.Task

  action_fallback Tasks3Web.FallbackController

  def index(conn, _params) do
    tasks = Todo.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => task_params, "token" => token}) do
    {:ok, user_id} = Phoenix.Token.verify(conn, "auth token", token, max_age: 86400)
    if task_params["user_id"] != user_id do
      IO.inspect({:bad_match, task_params["user_id"], user_id})
      raise "Dude, not ok!"
    end

    with {:ok, %Task{} = task} <- Todo.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", task_path(conn, :show, task))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Todo.get_task!(id)
    render(conn, "show.json", task: task)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Todo.get_task!(id)

    with {:ok, %Task{} = task} <- Todo.update_task(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Todo.get_task!(id)
    with {:ok, %Task{}} <- Todo.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end
