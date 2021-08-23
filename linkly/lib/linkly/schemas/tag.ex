defmodule Linkly.Schema.Tag do
  use Ecto.Schema
  # requires changeset
  schema "tags" do
    field :title, :string

    timestamps()
  end
end
