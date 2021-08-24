import Ecto.Query
import Ecto.Changeset
alias Ecto.Adapters.SQL
alias Linkly.Repo
alias Linkly.{Bookmark, Link, LinkTag, Tag, User}

links_to_insert =
  [
    [
      url: "https://alchemist.camp",
      inserted_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    ],
    [
      url: "https://reactor.am",
      inserted_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    ],
    [url: "https://indiehackers.com",
      inserted_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    ]
  ]

users_to_insert =
  [
    [
      username: "alice",
      email: "alice@example.com",
      inserted_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    ],
    [
      username: "bob",
      email: "bob@example.com",
      inserted_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    ],
    [
      username: "alchemist",
      email: "alchemist.camp@gmail.com",
      inserted_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    ]
  ]


bookmarks_to_insert =
  [
    [
      title: "A site with lots of Elixir tutorials",
      user_id: 1, link_id: 1,
      inserted_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    ],
    [
      title: "Alchemist Camp",
      user_id: 2, link_id: 1,
      inserted_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    ],
    [
      title: "Reactor Podcast",
      user_id: 2, link_id: 2,
      inserted_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    ],
    [
      title: "IH",
      user_id: 1, link_id: 3,
      inserted_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    ]
  ]

Repo.insert_all "users", users_to_insert, returning: [:id, :username]
Repo.insert_all "links", links_to_insert, returning: [:id, :url]
Repo.insert_all "bookmarks", bookmarks_to_insert

Repo.query("select * from users")

get_user2 = from u in "users", where: u.id == 2, select: u.username

get_bob = from u in "users", where: u.username == "bob", select: u.id

Repo.one(get_user2)
Ecto.Adapters.SQL.explain(Linkly.Repo, :all, get_bob) |> IO.puts
Repo.one(get_bob)
Repo.all(get_bob)

get_bookmarks = from "bookmarks", select: [:user_id, :link_id, :title]
Repo.all(get_bookmarks)

get_alice_bookmarks =
  from b in "bookmarks",
  where: b.user_id == 1,
  select: [:user_id, :link_id, :title]
Repo.all(get_alice_bookmarks)

get_alice_bookmarks2 =
  from u in "users",
  where: u.username == "alice",
  join: b in "bookmarks", on: b.user_id == u.id,
  join: l in "links", on: b.link_id == l.id,
  select: [u.username, l.url, b.title]
Repo.all(get_alice_bookmarks2)

# Use the username to trigger updates
name = "bob"
by_name = from u in "users", where: u.username == ^name
{1, _} = Repo.update_all(by_name, set: [email: "robert@example.com"])

# As well as for deletes
# {1, _} = Repo.delete_all post

third_user = %User{
  username: "sam",
  email: "sam@example.com",
  about: "I like to laugh. Haha haha..."
}

Repo.insert(%User{username: "sam", email: "sam@example.com", about: "I do not like green eggs and ham. No I don't. I don't like them one bit!"})

sam_query = from User, where: [username: "sam"]
Repo.update_all(sam_query, set: [email: "sam@gmail.com"])

query = from b in Bookmark, where b.link_id == 1
Repo.aggregate(query, :count, :id)


# changesets
# 1.  changing the url
# get the link
manning = Repo.get!(Link, 4)
%Linkly.Link{
  __meta__: #Ecto.Schema.Metadata<:loaded, "links">,
  bookmarks: #Ecto.Association.NotLoaded<association :bookmarks is not loaded>,
  id: 4,
  inserted_at: ~N[2021-02-10 18:23:02],
  taggings: #Ecto.Association.NotLoaded<association :taggings is not loaded>,
  tags: #Ecto.Association.NotLoaded<association :tags is not loaded>,
  updated_at: ~N[2021-02-10 18:23:02],
  url: "https://manning.com",
  users: #Ecto.Association.NotLoaded<association :users is not loaded>
}

# create changeset with change()
cs = change(manning, %{url: "nostarch.com"})
#Ecto.Changeset<
  action: nil,
  changes: %{url: "nostarch.com"},
  errors: [],
  data: #Linkly.Link<>,
  valid?: true
>

Repo.update(cs)
