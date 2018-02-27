defmodule Tasks.Repo.Migrations.ChangeBlockToTimeblock do
  use Ecto.Migration

  def change do
    rename table(:blocks), :block_id, to: :timeblock_id
  end
end
