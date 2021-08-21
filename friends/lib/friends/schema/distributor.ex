defmodule Friends.Schema.Distributor do
  use Ecto.Schema

  schema "distributors" do
    field :name, :string
    field :movie_id, :integer
    belongs_to(:movies, Friends.Schema.Movie)
  end
end
