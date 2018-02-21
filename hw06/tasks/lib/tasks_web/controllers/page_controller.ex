defmodule TasksWeb.PageController do
  use TasksWeb, :controller

  def index(conn, _params) do
    if get_session(conn, :user_id) do
      redirect(conn, to: "/tasks")
    else
      render conn, "index.html"
    end
  end

  #Taken from Nat Tuck's lecture notes
  def feed(conn, _params) do
    tasks = Tasks.Todo.list_tasks()
    changeset = Tasks.Todo.change_task(%Tasks.Todo.Task{})
    render conn, "feed.html", tasks: tasks, changeset: changeset
  end
end
