defmodule Invites.Contexts.InvitesManager do
  @moduledoc """
  Manejador de templates de invitaciones.
  """

  import Ecto.{Query, Changeset}, warn: false

  alias Invites.Repo
  alias Invites.Contexts.Invites
  alias Ecto.Changeset

  @fields [:template]
  @required [:template]

  @doc """
  Lista todas las preguntas.
  """
  def list do
    Invites
    |> preload(:texts)
    |> Repo.all()
  end

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
    |> preload(:texts)
    |> Repo.get(id)
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
  Devuelve un changeset para el schema de templates de invitaciones.
  """
  @spec get_changeset(struct, struct) :: struct
  def get_changeset(struct \\ %Invites{}, params \\ %{}) do
    changeset(struct, params)
  end

  defp changeset(%Invites{} = struct, attrs \\ %{}) do
    struct
    |> cast(attrs, @fields)
    |> Changeset.cast_assoc(:texts, required: false)
    |> validate_required(@required)
  end
end
