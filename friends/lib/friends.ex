defmodule Friends do
  alias Friends.Repo
  alias Friends.Schema.Person
  import Ecto.Query
  @moduledoc """
  Documentation for `Friends`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Friends.hello()
      :world

  """
  def hello do
    :world
  end

  def insert(friend) do
    Repo.insert!(friend)
  end

  def list_all_friends() do
    query = from person in Person, select: {person.id, person.name, person.age}
    Repo.all(query)
  end

  def update_friend(id, updated_friend) do
    friend_in_db = Repo.get!(Person, id)
    friend = Person.changeset(friend_in_db, updated_friend)
    Repo.update(friend)

    # funciton call -> update_friend 5, %{name: "K Mathew"}
  end

  def remove_friend(id) do
    friend = Repo.get! Person, id
    Repo.delete!(friend)
  end
end
