defmodule Tasks.Repo.Migrations.AddFieldToTasks do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :completed, :boolean
    end
  end
end
