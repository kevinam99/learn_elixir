import Config

config :friends, Friends.Repo,
  database: "friends_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"

config :friends,
ecto_repos: [Friends.Repo]
