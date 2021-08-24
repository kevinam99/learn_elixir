defmodule Linkly.Schema.LinkTag do
  use Ecto.Schema
  alias Linkly.Schema.{Link, Tag, User}

  schema "link_tags" do
    # field(:link_id, :id)
    # field(:tag_id, :id)
    # field(:user_id, :id)
    belongs_to(:link, Link)
    belongs_to(:tag, Tag)
    belongs_to(:user, User)
    timestamps()
  end
end
