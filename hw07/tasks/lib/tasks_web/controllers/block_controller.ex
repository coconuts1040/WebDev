defmodule TasksWeb.BlockController do
  use TasksWeb, :controller

  alias Tasks.Todo
  alias Tasks.Todo.Block

  action_fallback TasksWeb.FallbackController

  def index(conn, _params) do
    blocks = Todo.list_blocks()
    render(conn, "index.json", blocks: blocks)
  end

  def create(conn, %{"block" => block_params}) do
    with {:ok, %Block{} = block} <- Todo.create_block(block_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", block_path(conn, :show, block))
      |> render("show.json", block: block)
    end
  end

  def show(conn, %{"id" => id}) do
    block = Todo.get_block!(id)
    render(conn, "show.json", block: block)
  end

  def update(conn, %{"id" => id, "block" => block_params}) do
    block = Todo.get_block!(id)

    with {:ok, %Block{} = block} <- Todo.update_block(block, block_params) do
      render(conn, "show.json", block: block)
    end
  end

  def delete(conn, %{"id" => id}) do
    block = Todo.get_block!(id)
    with {:ok, %Block{}} <- Todo.delete_block(block) do
      send_resp(conn, :no_content, "")
    end
  end
end
