defmodule Friends.Schema.Person do
  use Ecto.Schema

  schema "people" do
    field :name, :string, null: false
    field :age, :integer, default: 0

    timestamps()
  end
end
