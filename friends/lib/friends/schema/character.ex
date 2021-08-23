defmodule Friends.Schema.Character do
  use Ecto.Schema

  schema "characters" do
    field :name, :string
    # field :movie_id, :integer
    belongs_to(:movie, Friends.Schema.Movie)

    # In addition to adding the foreign key movie_id to our schema, it also gives us the ability to
    # access associated movies schema through characters. It uses the foreign key
    # to make a character’s associated movie available when we query for them. This is what will allow us to call character.movie.
  end
end
