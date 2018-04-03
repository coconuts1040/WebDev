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
