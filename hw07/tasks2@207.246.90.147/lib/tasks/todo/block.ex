defmodule Tasks.Todo.Block do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks.Todo.Block


  schema "blocks" do
    field :start, :time, null: false
    field :end, :time, null: false
    belongs_to :task, Tasks.Todo.Task

    timestamps()
  end

  @doc false
  def changeset(%Block{} = block, attrs) do
    block
    |> cast(attrs, [:start, :end, :task_id])
    |> validate_required([:start, :end, :task_id])
    #|> validate_times()
  end

  def validate_times(changeset) do
    block = Map.get(changeset, :data)
    start = Map.get(block, :start)
    end0 = Map.get(block, :end)

    if start < end0 do
      changeset
    else
      {:error, %Ecto.Changeset{}}
    end
  end

end
