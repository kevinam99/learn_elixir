defmodule Friends.Schema.Movie do
  use Ecto.Schema

  schema "movies" do
    field :title, :string
    field :tagline, :string
    has_one(:distributor, Friends.Schema.Distributor)
    has_many(:characters, Friends.Schema.Character)
    many_to_many(:actors, Friends.Schema.Actor, join_through: :movies_actors)
    # has_many/3 uses the foreign key on the associated schema, "characters", to make a movie’s associated
    # characters available. This is what will allow us to call movie.characters.
  end
end
