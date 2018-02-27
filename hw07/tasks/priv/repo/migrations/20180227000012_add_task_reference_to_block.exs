defmodule Tasks.Repo.Migrations.AddTaskReferenceToBlock do
  use Ecto.Migration

  def change do
    alter table(:blocks) do
      add :task_id, references(:tasks, on_delete: :delete_all)
    end
  end
end
