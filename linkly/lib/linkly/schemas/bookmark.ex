defmodule Linkly.Schema.Bookmark do
  use Ecto.Schema
  import Ecto.Changeset
  alias Linkly.Schema.{Bookmark, Link, User}

  schema "bookmarks" do
    field(:title)
    belongs_to(:link, Link)
    belongs_to(:user, User)

    timestamps()
  end

  def changeset(%Bookmark{} = bookmark, attrs) do
    bookmark
    |> cast(attrs, [:title, :link_id, :user_id]) # allowed changes
    |> validate_required([:title, :link_id, :user_id])
    |> unique_constraint([:link_id, :user_id])
  end
end
