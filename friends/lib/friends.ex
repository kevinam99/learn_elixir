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

  @doc """
     ## Examples
      alias Friends.Repo
      alias Friends.Schema.{Actor, Character, Distributor, Movie, MoviesActors}

     iex> movie = %Friends.Schema.Movie{title: "Ready Player One", tagline: "Something about games"}
     %Friends.Schema.Movie{
       __meta__: #Ecto.Schema.Metadata<:built, "movies">,
       actors: #Ecto.Association.NotLoaded<association :actors is not loaded>,
       characters: #Ecto.Association.NotLoaded<association :characters is not loaded>,
       distributor: #Ecto.Association.NotLoaded<association :distributor is not loaded>,
       id: nil,
       tagline: "Something about games",
       title: "Ready Player One"
     }

   iex> movie = Friends.Repo.insert! movie
   %Friends.Schema.Movie{
     __meta__: #Ecto.Schema.Metadata<:loaded, "movies">,
     actors: #Ecto.Association.NotLoaded<association :actors is not loaded>,
     characters: #Ecto.Association.NotLoaded<association :characters is not loaded>,
     distributor: #Ecto.Association.NotLoaded<association :distributor is not loaded>,
     id: 1,
     tagline: "Something about games",
     title: "Ready Player One"
   }
      iex> character = Ecto.build_assoc(movie, :characters, %{name: "Wade Watts"})
      %Friends.Schema.Character{
        __meta__: #Ecto.Schema.Metadata<:built, "characters">,
        id: nil,
        movie_id: 1,
        movies: #Ecto.Association.NotLoaded<association :movies is not loaded>,
        movies_id: nil,
        name: "Wade Watts"
      }

      iex> character = Repo.insert! character
      %Friends.Schema.Character{
      __meta__: #Ecto.Schema.Metadata<:loaded, "characters">,
      id: 1,
      movie_id: 1,
      movies: #Ecto.Association.NotLoaded<association :movies is not loaded>,
      movies_id: nil,
      name: "Wade Watts"
      }

      iex> distributor = Ecto.build_assoc(movie, :distributor, %{name: "Netflix"})
      %Friends.Schema.Distributor{
      __meta__: #Ecto.Schema.Metadata<:built, "distributors">,
      id: nil,
      movie_id: 1,
      movies: #Ecto.Association.NotLoaded<association :movies is not loaded>,
      movies_id: nil,
      name: "Netflix"
      }

      iex> distributor = Repo.insert! distributor
      %Friends.Schema.Distributor{
      __meta__: #Ecto.Schema.Metadata<:loaded, "distributors">,
      id: 1,
      movie_id: 1,
      movies: #Ecto.Association.NotLoaded<association :movies is not loaded>,
      movies_id: nil,
      name: "Netflix"
      }

      actor = %Actor{name: "Tyler Sheridan"}
      actor = Repo.insert!(actor)
  """
end
