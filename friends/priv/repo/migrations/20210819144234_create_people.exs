defmodule Friends.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table(:people) do
      add :name, :text
      add :age, :decimal, precision: 3, scale: 0, default: 0

      timestamps
    end
  end
end
