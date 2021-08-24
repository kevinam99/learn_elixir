defmodule Linkly.Schema.LinkTag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Linkly.Schema.{Link, Tag, User, LinkTag}

  schema "link_tags" do
    # field(:link_id, :id)
    # field(:tag_id, :id)
    # field(:user_id, :id)
    belongs_to(:link, Link)
    belongs_to(:tag, Tag)
    belongs_to(:user, User)
    timestamps()
  end

  def changeset(%LinkTag{} = link_tag, attrs) do
    link_tag
    |> cast(attrs, [:link, :tag, :user])
    |> validate_required([:link, :tag, :user])
    |> unique_constraint([:link, :tag, :user])
  end
  # keep in mind, since this table contains ONLY joins,
  # it is important to i nclude foreign keys in the
  # required fields' list. Else, the changest will be discarded.

end
