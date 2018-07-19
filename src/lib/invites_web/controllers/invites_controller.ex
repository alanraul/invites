defmodule InvitesWeb.InvitesController do
  use InvitesWeb, :controller

  alias Invites.Contexts.InvitesManager
  alias Invites.Contexts.Invites
  alias InvitesWeb.ErrorView

  require Logger

  @doc """
  Lista todas las invitaciones.
  """
  @spec index(map, map):: map
  def index(conn, _params) do
    invites = InvitesManager.list()
    IO.inspect("===========")
    IO.inspect(invites)

    render(conn, "index.json", invites: invites)
  end

  @doc """
  Guarda los datos de una nueva invitación.
  """
  @spec create(map, map):: map
  def create(conn, %{"invite" => invite_params}) do
    case InvitesManager.create(invite_params) do
      {:ok, invite} ->
        render(conn, "show.json", invite: invite)
      {:error, error} ->
        Logger.error "No create invite: #{inspect(error)}"

        render(conn, ErrorView, "500.json")
    end
  end

  @doc """
  Guarda los datos de una nueva invitación.
  """
  @spec show(map, map):: map
  def show(conn, %{"id" => id}) do
    case InvitesManager.get(id) do
      nil ->
        render(conn, ErrorView, "404.json")
      invite ->
        render(conn, "show.json", invite: invite)
    end
  end

  @doc """
  Guarda los datos de una nueva invitación.
  """
  @spec update(map, map):: map
  def update(conn, %{"id" => id, "invite" => invite_params}) do
    with %Invites{} = invite <- InvitesManager.get(id),
      {:ok, invite} <- InvitesManager.update(invite, invite_params) do
        render(conn, "show.json", invite: invite)
    else
      nil ->
        render(conn, ErrorView, "404.json")
      {:error, error} ->
        Logger.error "No update invite: #{inspect(error)}"

        render(conn, ErrorView, "500.json")
    end
  end

  @doc """
  Guarda los datos de una nueva invitación.
  """
  @spec delete(map, map):: map
  def delete(conn, %{"id" => id}) do
    with %Invites{} = invite <- InvitesManager.get(id),
      {:ok, invite} <- InvitesManager.delete(invite) do
        render(conn, "show.json", invite: invite)
    else
      nil ->
        render(conn, ErrorView, "404.json")
      {:error, error} ->
        Logger.error "No delete invite: #{inspect(error)}"

        render(conn, ErrorView, "500.json")
    end
  end
end
