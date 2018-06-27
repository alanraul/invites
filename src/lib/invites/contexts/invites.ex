defmodule Invites.Contexts.Invites do
  @moduledoc """
  Esquema de respuestas divertidas a preguntas regulares.
  """
  use Ecto.Schema

  schema "invites" do
    field :template_uri, :string, [null: false]
    field :coordinates, {:array, :string}, [null: false]
    field :font_uri, :string, [null: false]
    field :font_size, :string, [null: false, default: 18]
    field :column_width, :string, [null: false, default: 20]
    field :color, :string, [null: false, default: "0,0,0"]

    timestamps()
  end

end
