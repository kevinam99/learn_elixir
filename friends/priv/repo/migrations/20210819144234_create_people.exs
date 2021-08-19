defmodule Friends.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table(:people) do
      add :name, :text
      add :age, :integer, default: 0

      timestamps()
    end
  end
end
