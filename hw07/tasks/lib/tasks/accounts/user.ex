defmodule Tasks.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks.Accounts.User
  alias Tasks.Todo.Manage

  schema "users" do
    field :email, :string, null: false
    field :name, :string, null: false
    has_many :manager_follows, Manage, foreign_key: :manager_id
    has_many :managee_follows, Manage, foreign_key: :managee_id
    has_many :managers, through: [:managee_follows, :manager]
    has_many :managees, through: [:manager_follows, :managee]

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name])
    |> validate_required([:email, :name])
  end
end
