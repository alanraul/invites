defmodule Invites.Contexts.Invites do
  @moduledoc """
  Esquema para templates de invitaciones.
  """
  use Ecto.Schema

  alias Invites.Contexts.Texts

  schema "invites" do
    field :template, :string, [null: false]

    has_many :texts, Texts

    timestamps()
  end

end
