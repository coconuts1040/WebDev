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
    tasks = Enum.reverse(Tasks.Todo.feed_tasks_for(conn.assigns[:current_user]))
    changeset = Tasks.Todo.change_task(%Tasks.Todo.Task{})
    render conn, "feed.html", tasks: tasks, changeset: changeset
  end
end
