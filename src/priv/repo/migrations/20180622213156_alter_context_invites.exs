defmodule Invites.Repo.Migrations.AlterContextInvites do
  use Ecto.Migration

  def up do
    alter table(:invites) do
      remove :coordinates

      add :font_uri, :string, [
        null: false,
        default: "https://s3.us-east-2.amazonaws.com/invites-fonts/TypoSlab_demo.otf"
      ]
      add :font_size, :string, [null: false, default: "18"]
      add :column_width, :string, [null: false, default: "20"]
      add :color, :string, [null: false, default: "0,0,0"]
      add :coordinates, {:array, :string}, [null: false, default: fragment("ARRAY['100,100']")]
    end

    rename table(:invites), :uri, to: :template_uri
  end

  def down do
    alter table(:invites) do
      remove :coordinates
      remove :font_uri
      remove :font_size
      remove :column_width
      remove :color

      add :coordinates, :string, [null: false, default: "100,100"]
    end

    rename table(:invites), :template_uri, to: :uri
  end
end
