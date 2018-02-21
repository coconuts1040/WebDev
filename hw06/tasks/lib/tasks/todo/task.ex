defmodule Tasks.Todo.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks.Todo.Task


  schema "tasks" do
    field :description, :string
    field :progress, :integer
    field :title, :string
    field :completed, :boolean
    belongs_to :user, Tasks.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :progress, :completed, :user_id])
    |> round_to_15()
    |> validate_required([:title, :description, :progress, :completed, :user_id])
  end

  #Returns a task whose progress value is rounded down to the nearest 15 minutes
  def round_to_15(changeset) do
    task = Map.get(changeset, :data)
    progress = Map.get(task, :progress)
    if progress do
      prog_round = progress - rem(progress, 15)
      new_task = %{ task | progress: prog_round }
      %{ changeset | data: new_task }
    else
      changeset
    end
  end
end
