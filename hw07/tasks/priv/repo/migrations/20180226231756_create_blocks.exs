defmodule Tasks.Repo.Migrations.CreateBlocks do
  use Ecto.Migration

  def change do
    create table(:blocks) do
      add :block_id, references(:timeblocks, on_delete: :delete_all)

      timestamps()
    end

    create index(:blocks, [:block_id])
  end
end
