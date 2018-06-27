defmodule Invites.Contexts.InvitesManager do
  @moduledoc """
  Manejador de funny answer.
  """

  import Ecto.{Query, Changeset}, warn: false

  alias Invites.Repo
  alias Invites.Contexts.Invites

  @fields [
    :template_uri, :coordinates, :font_uri, :font_size, :column_width, :color
  ]
  @required [
    :template_uri, :coordinates, :font_uri, :font_size, :column_width, :color
  ]

  @doc """
  Lista todas las preguntas.
  """
  def list, do: Repo.all(Invites)

  @doc """
  Crea un pregunta.
  """
  @spec create(map) :: struct
  def create(attrs \\ %{}) do
    %Invites{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Busca una pregunta por id.
  """
  @spec get(integer) :: struct
  def get(id) do
    Invites
    |> where([u], u.id == ^id)
    |> Repo.one()
  end

  @doc """
  Actualiza un pregunta.
  """
  @spec update(struct, map) :: struct
  def update(%Invites{} = struct, attrs) do
    struct
    |> changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Elimina una pregunta.
  """
  @spec delete(map) :: tuple
  def delete(%Invites{} = struct) do
    Repo.delete(struct)
  end

  @doc """
  Devuelve un changeset para el schema de funny answers.
  """
  @spec get_changeset(struct, struct) :: struct
  def get_changeset(struct \\ %Invites{}, params \\ %{}) do
    changeset(struct, params)
  end

  defp changeset(%Invites{} = struct, attrs \\ %{}) do
    struct
    |> cast(attrs, @fields)
    |> validate_required(@required)
  end
end
