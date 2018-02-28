defmodule Tasks.Repo.Migrations.ChangeTimeToInt do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      remove :progress
      add :progress, :integer
    end
  end
end
