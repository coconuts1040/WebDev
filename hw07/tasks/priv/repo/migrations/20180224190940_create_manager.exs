defmodule Tasks.Repo.Migrations.CreateManager do
  use Ecto.Migration

  def change do
    create table(:manager) do
      add :manager_id, references(:users, on_delete: :delete_all), null: false
      add :managee_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:manager, [:manager_id])
    create index(:manager, [:managee_id])
  end
end
