defmodule Friends.Schema.Movie do
  use Ecto.Schema

  schema "movies" do
    field :title, :string
    field :tagline, :string
    has_many(:characters, Friends.Schema.Character)
    # has_many/3 uses the foreign key on the associated schema, "characters", to make a movie’s associated
    # characters available. This is what will allow us to call movie.characters.
  end
end
