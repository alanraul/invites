defmodule Invites.Repo.Migrations.CreateContextsInvites do
  use Ecto.Migration

  def up do
    create table(:invites) do
      add :uri, :string, [null: false]
      add :coordinates, :string, [null: false]

      timestamps()
    end

  end

  def down do
  	drop table(:invites)
  end
end
