use Mix.Config

config :cart, Cart.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "cart_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"


# With the line we are telling Ecto which repos we are using.
# This is a cool feature since it allows us to have many repos, i.e. we can connect to multiple databases.
config :cart, ecto_repos: [Cart.Repo]
# now run the command: mix ecto.gen.repo
