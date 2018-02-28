defmodule Tasks.Repo.Migrations.RemoveTimeblock do
  use Ecto.Migration

  def change do
    drop table(:blocks)
    drop table(:timeblocks)
  end
end
