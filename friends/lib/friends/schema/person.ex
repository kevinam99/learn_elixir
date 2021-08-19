defmodule Friends.Schema.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people" do
    field :name, :string, null: false
    field :age, :integer, default: 0

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :age])
    |> validate_required([:name])
    |> validate_length(:name, min: 2)
    |> validate_number(:age, greater_than_or_equal_to: 18)
  end
end
