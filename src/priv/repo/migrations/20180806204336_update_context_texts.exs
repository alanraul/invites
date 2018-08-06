defmodule Invites.Repo.Migrations.UpdateContextTexts do
  use Ecto.Migration

  def up do
    alter table(:texts) do

      add :align, :string, [null: false, default: "center"]
      add :spacing, :integer, [null: false, default: 10]
    end

    rename table(:texts), :column_width, to: :number_char
  end

  def down do
    alter table(:texts) do

      remove :number_char
      remove :align
      remove :spacing
    end
  end
end
