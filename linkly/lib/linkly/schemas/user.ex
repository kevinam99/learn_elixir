defmodule Linkly.Schema.User do
  use Ecto.Schema
  alias Linkly.Schema.Bookmark

  schema "users" do
    field(:about, :string)
    field(:username, :string)
    field(:email, :string)
    has_many(:bookmarks, Bookmark)
    has_many(:bookmarked_links, through: [:bookmarks, :link])
    timestamps()
  end
end
