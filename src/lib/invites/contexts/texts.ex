defmodule Invites.Contexts.Texts do
  @moduledoc """
  Esquema para textos de una invitación.
  """
  use Ecto.Schema

  alias Invites.Contexts.Invites

  schema "texts" do
    field :color, :string, [null: false]
    field :column_width, :integer, [null: false]
    field :coordinates, :string, [null: false]
    field :font, :string, [null: false]
    field :size, :integer, [null: false]
    field :tag, :string, [null: false]

    belongs_to :invite, Invites

    timestamps()
  end

end
