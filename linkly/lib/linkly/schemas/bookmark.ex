defmodule Linkly.Schema.Bookmark do
  use Ecto.Schema
  alias Linkly.Schema.{Link, User}
  schema "bookmarks" do
    field :title
    belongs_to(:link, Link)
    belongs_to(:user, User)

    timestamps()
  end
end
