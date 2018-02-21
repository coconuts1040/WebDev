defmodule Tasks.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks.Accounts.User


  schema "users" do
    field :email, :string, null: false
    field :name, :string, null: false

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name])
    |> validate_required([:email, :name])
  end
end
