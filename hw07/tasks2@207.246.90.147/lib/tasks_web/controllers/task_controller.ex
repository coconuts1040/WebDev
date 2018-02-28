defmodule TasksWeb.TaskController do
  use TasksWeb, :controller

  alias Tasks.Todo
  alias Tasks.Todo.Task

  def index(conn, _params) do
    tasks = Todo.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Todo.change_task(%Task{})
    current_user = conn.assigns[:current_user]
    follows = Todo.managees_by_user(current_user)
    render(conn, "new.html", changeset: changeset, follows: follows)
  end

  def create(conn, %{"task" => task_params}) do
    case Todo.create_task(task_params) do
      {:ok, task} ->
        task_id = Map.fetch(task, :id)
                  |> elem(1)
        start_param = task_params["start"]
        end_param = task_params["end"]
        block_params = %{ "start"=>start_param, "end"=>end_param, "task_id"=>task_id }
        case Todo.create_block(block_params) do
          {:ok, _block} ->
            conn
            |> put_flash(:info, "Task created successfully.")
            |> redirect(to: task_path(conn, :show, task))
          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "new.html", changeset: changeset)
        end
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Todo.get_task!(id)
    blocks = Todo.blocks_map_for(id)
    render(conn, "show.html", task: task, blocks: blocks)
  end

  def edit(conn, %{"id" => id}) do
    task = Todo.get_task!(id)
    changeset = Todo.change_task(task)
    blocks = Todo.blocks_map_for(id)
    render(conn, "edit.html", task: task, changeset: changeset, blocks: blocks)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Todo.get_task!(id)

    case Todo.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Todo.get_task!(id)
    {:ok, _task} = Todo.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end
end
