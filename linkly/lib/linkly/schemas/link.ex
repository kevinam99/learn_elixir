defmodule Linkly.Schema.Link do
  use Ecto.Schema
  alias Linkly.Schema.Bookmark

  schema "links" do
    field(:url, :string)
    has_many(:bookmarks, Bookmark)
    timestamps()
  end
end
