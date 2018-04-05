# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tasks3.Repo.insert!(%Tasks3.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
# Taken from Nat Tuck's lecture notes
defmodule Seeds do
  alias Tasks3.Repo
  alias Tasks3.Accounts.User
  alias Tasks3.Todo.Task

  def run do
    p = Comeonin.Argon2.hashpwsalt("CriticalRole")
    Repo.delete_all(User)
    a = Repo.insert!(%User{ name: "Jeff", email: "jeff@example.com", password_hash: p })
    b = Repo.insert!(%User{ name: "Jacob", email: "jacob123@example.com", password_hash: p })
    c = Repo.insert!(%User{ name: "William", email: "coconuts1040@gmail.com", password_hash: p })

    Repo.delete_all(Task)
    Repo.insert!(%Task{ user_id: a.id, title: "Do task 1", description: "do stuff 1", progress: 0, completed: false })
    Repo.insert!(%Task{ user_id: b.id, title: "Do task 2", description: "do stuff 2", progress: 0, completed: false })
    Repo.insert!(%Task{ user_id: c.id, title: "Do task 3", description: "do stuff 3", progress: 0, completed: false })
    Repo.insert!(%Task{ user_id: a.id, title: "Do task 4", description: "do stuff 4", progress: 0, completed: true })
  end
end

Seeds.run
