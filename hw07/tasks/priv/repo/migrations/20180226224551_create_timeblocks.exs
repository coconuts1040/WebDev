defmodule Tasks.Repo.Migrations.CreateTimeblocks do
  use Ecto.Migration

  def change do
    create table(:timeblocks) do
      add :start, :time, null: false
      add :end, :time, null: false

      timestamps()
    end

  end
end
