defmodule Friends.Schema.Distributor do
  use Ecto.Schema

  schema "distributors" do
    field :name, :string
    belongs_to(:movie, Friends.Schema.Movie)
  end
end
