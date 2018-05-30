defmodule Invites.Contexts.Invites do
  @moduledoc """
  Esquema de respuestas divertidas a preguntas regulares.
  """
  use Ecto.Schema

  schema "invites" do
    field :uri, :string, [null: false]
    field :coordinates, :string, [null: false]

    timestamps()
  end

end
