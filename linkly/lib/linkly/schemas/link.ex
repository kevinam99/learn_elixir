defmodule Linkly.Schema.Link do
  use Ecto.Schema
  alias Linkly.Schema.{Bookmark, LinkTag, Tag}

  schema "links" do
    field(:url, :string)
    has_many(:bookmarks, Bookmark)
    has_many(:taggings, LinkTag)
    many_to_many(:tags, Tag, join_through: LinkTag)
    timestamps()
  end
end
