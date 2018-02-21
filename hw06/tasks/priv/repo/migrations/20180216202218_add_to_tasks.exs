defmodule Tasks.Repo.Migrations.AddToTasks do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :completed
    end
    alter table(:tasks) do
      add :completed, :boolean
    end
  end
end
