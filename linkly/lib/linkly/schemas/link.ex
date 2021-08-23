defmodule Linkly.Schema.Link do
  use Ecto.Schema

  schema "links" do
    field :url, :string

    timestamps()
  end
end
