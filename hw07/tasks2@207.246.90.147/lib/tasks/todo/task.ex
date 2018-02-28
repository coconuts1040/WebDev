defmodule Tasks.Todo.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks.Todo.Task


  schema "tasks" do
    field :description, :string
    field :title, :string
    field :completed, :boolean
    belongs_to :user, Tasks.Accounts.User
    has_many :time_blocks, Tasks.Todo.Block

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed, :user_id])
    |> validate_required([:title, :description, :completed, :user_id])
  end
end
