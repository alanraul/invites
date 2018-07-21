defmodule Invites.Contexts.TextsManager do
  @moduledoc """
  Manejador de textos para invitación.
  """

  import Ecto.{Query, Changeset}, warn: false

  alias Invites.Repo
  alias Invites.Contexts.Texts

  @fields [
    :coordinates, :font, :column_width, :color, :tag, :size, :invite_id
  ]
  @required [
    :coordinates, :font, :column_width, :color, :tag, :size
  ]

  @doc """
  Lista todas los textos.
  """
  def list, do: Repo.all(Texts)

  @doc """
  Crea un texto.
  """
  @spec create(map) :: struct
  def create(attrs \\ %{}) do
    %Texts{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Busca una texto por id.
  """
  @spec get(integer) :: struct
  def get(id) do
    Texts
    |> where([u], u.id == ^id)
    |> Repo.one()
  end

  @doc """
  Actualiza un texto.
  """
  @spec update(struct, map) :: struct
  def update(%Texts{} = struct, attrs) do
    struct
    |> changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Elimina una texto.
  """
  @spec delete(map) :: tuple
  def delete(%Texts{} = struct) do
    Repo.delete(struct)
  end

  @doc """
  Devuelve un changeset para el schema de texto.
  """
  @spec get_changeset(struct, struct) :: struct
  def get_changeset(struct \\ %Texts{}, params \\ %{}) do
    changeset(struct, params)
  end

  defp changeset(%Texts{} = struct, attrs \\ %{}) do
    struct
    |> cast(attrs, @fields)
    |> validate_required(@required)
  end
end
