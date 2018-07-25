defmodule InvitesWeb.TextsController do
  use InvitesWeb, :controller

  alias Invites.Contexts.TextsManager
  alias Invites.Contexts.Texts
  alias InvitesWeb.ErrorView

  require Logger

  @doc """
  Guarda los datos de un texto de una invitación.
  """
  @spec create(map, map):: map
  def create(conn, %{"text" => text_params}) do
    case TextsManager.create(text_params) do
      {:ok, text} ->
        render(conn, "show.json", texts: text)
      {:error, error} ->
        Logger.error "No create text: #{inspect(error)}"

        render(conn, ErrorView, "500.json")
    end
  end

  @doc """
  Muestra un texto buscando por id.
  """
  @spec show(map, map):: map
  def show(conn, %{"id" => id}) do
    case TextsManager.get(id) do
      nil ->
        render(conn, ErrorView, "404.json")
      text ->
        IO.inspect(text)
        render(conn, "show.json", texts: text)
    end
  end

  @doc """
  Actualiza los elementos de un texto.
  """
  @spec update(map, map):: map
  def update(conn, %{"id" => id, "text" => text_params}) do
    with %Texts{} = text <- TextsManager.get(id),
      {:ok, text} <- TextsManager.update(text, text_params) do
        render(conn, "show.json", texts: text)
    else
      nil ->
        render(conn, ErrorView, "404.json")
      {:error, error} ->
        Logger.error "No update text: #{inspect(error)}"

        render(conn, ErrorView, "500.json")
    end
  end

  @doc """
  Elimina un texto.
  """
  @spec delete(map, map):: map
  def delete(conn, %{"id" => id}) do
    with %Texts{} = text <- TextsManager.get(id),
      {:ok, text} <- TextsManager.delete(text) do
        render(conn, "show.json", texts: text)
    else
      nil ->
        render(conn, ErrorView, "404.json")
      {:error, error} ->
        Logger.error "No delete text: #{inspect(error)}"

        render(conn, ErrorView, "500.json")
    end
  end
end
