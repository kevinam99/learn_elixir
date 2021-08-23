defmodule Linkly.Schemas.User do
  use Ecto.Schema

  schema "users" do
    field :about, :string
    field :username, :string
    field :email, :string

    timestamps()
  end
end
