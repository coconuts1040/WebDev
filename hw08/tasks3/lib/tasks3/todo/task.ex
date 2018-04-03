defmodule Tasks3.Todo.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :completed, :boolean, default: false, null: false
    field :description, :string, null: false
    field :progress, :integer, null: false
    field :title, :string, null: false
    belongs_to :user, Tasks3.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :progress, :completed, :user_id])
    |> validate_required([:title, :description, :progress, :completed, :user_id])
  end
end
