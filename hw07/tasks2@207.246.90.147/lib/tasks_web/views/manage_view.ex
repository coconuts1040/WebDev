defmodule TasksWeb.ManageView do
  use TasksWeb, :view
  alias TasksWeb.ManageView

  def render("index.json", %{manager: manager}) do
    %{data: render_many(manager, ManageView, "manage.json")}
  end

  def render("show.json", %{manage: manage}) do
    %{data: render_one(manage, ManageView, "manage.json")}
  end

  def render("manage.json", %{manage: manage}) do
    %{id: manage.id}
  end
end
