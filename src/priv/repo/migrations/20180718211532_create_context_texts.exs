defmodule Invites.Repo.Migrations.CreateContextTexts do
  use Ecto.Migration

  def up do
    drop table(:invites)

    create table(:invites) do
      add :template, :string, [null: false]

      timestamps()
    end

    create table(:texts) do
      add :color, :string, [null: false]
      add :column_width, :string, [null: false]
      add :coordinates, :string, [null: false]
      add :font, :string, [null: false]
      add :size, :string, [null: false]
      add :tag, :string, [null: false]

      add :invite_id, references(:invites), [null: false]

      timestamps()
    end

    create index(:texts, [:id])
  end

  def down do
    drop table(:texts)
    drop table(:invites)

    create table(:invites) do
      add :color, :string, [null: false, default: "0,0,0"]
      add :column_width, :string, [null: false, default: 20]
      add :coordinates, {:array, :string}, [null: false]
      add :font_size, :string, [null: false, default: 18]
      add :font_uri, :string, [null: false]
      add :template_uri, :string, [null: false]

      timestamps()
    end
  end
end
