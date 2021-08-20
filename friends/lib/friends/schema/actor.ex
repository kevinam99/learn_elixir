defmodule Friends.Schema.Actor do
  use Ecto.Schema

  schema "actors" do
    field :name, :string
    many_to_many(:movies, Friends.Schema.Movie, join_through: :movies_actors)
  end
end
