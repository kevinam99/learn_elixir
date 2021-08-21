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

      iex> Friends.insert(%Friends.Schema.Person{age: 91, name: "Somebody"})
      :ok

      iex> Friends.update_friend(1, %{name: "name from mix test"})
      :ok

      iex> Friends.update_friend(1, %{name: "na"})
      {:error, [
                  name: {"should be at least %{count} character(s)",
                  [count: 3, validation: :length, kind: :min, type: :string]}
                ]
      }

      iex> Friends.update_friend(1, %{age: 12})
      {:error,
          [
            age: {"must be greater than or equal to %{number}",
              [validation: :number, kind: :greater_than_or_equal_to, number: 18]}
          ]
      }


  """
  def hello do
    :world
  end

  def insert(friend) do
    case Repo.insert(friend) do
      {:ok, %Friends.Schema.Person{id: _id}} -> :ok
      {:error, reason}-> {:error, reason}
    end
  end

  def list_all_friends() do
    query = from person in Person, select: {person.id, person.name, person.age}
    Repo.all(query)
  end

  def update_friend(id, updated_friend) do
    friend_in_db = Repo.get!(Person, id)
    friend = Person.changeset(friend_in_db, updated_friend)
    case Repo.update(friend) do
      {:ok, _} -> :ok
      {:error, reason} -> {:error, reason.errors}
    end


    # funciton call -> update_friend 1, %{name: "K Mathew"}
  end

  def remove_friend(id) do
    friend = Repo.get! Person, id
    Repo.delete!(friend)
  end
end
