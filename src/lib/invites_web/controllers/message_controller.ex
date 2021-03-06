defmodule InvitesWeb.MessagesController do
  use InvitesWeb, :controller

  alias ExAws.S3
  alias Invites.Contexts.InvitesManager
  alias InvitesWeb.ErrorView

  require Logger

  @doc """
  Añade un mensaje al template de una invitación.
  """
  @spec create(map, map):: map
  def create(conn, %{"message" => message_params}) do
    case InvitesManager.get(message_params["invite_id"]) do
      nil ->
        render(conn, ErrorView, "404.json")
      invite ->
        texts = _get_texts(invite.texts, message_params["texts"])
        file_name = Ecto.UUID.generate()

        args = Poison.encode!(%{
          name: file_name,
          template: invite.template,
          texts: texts
        })

        [_name, extension] = String.split(invite.template)

        {"", 0} = System.cmd("#{System.cwd()}/pillow/dist/index", [args])

        upload_file(file_name, extension)

        render(conn, "message.json", message: %{
          uri: "https://s3.us-east-2.amazonaws.com/invites-messages/#{file_name}.#{extension}"
        })
    end
  end

  @spec _get_texts(list, list):: list
  defp _get_texts([], messages), do: []
  defp _get_texts([head | tail], messages) do
    [
      %{
        align: head.align,
        color: head.color,
        coordinates: head.coordinates,
        font: head.font,
        number_char: head.number_char,
        size: head.size,
        spacing: head.spacing,
        text: _get_message(head.tag, messages)
      }
      | _get_texts(tail, messages)
    ]
  end

  @spec _get_message(String.t, list):: String.t
  defp _get_message(tag, messages) do
    message = Enum.find(messages, fn(message) -> message["tag"] == tag end)
    if message == nil, do: "", else: message["text"]
  end

  def upload_file(file_name, extension) do
    file = "#{System.cwd()}/#{file_name}.#{extension}"

    Application.get_env(:invites, :buckets)[:messages]
    |> S3.put_object("#{file_name}.#{extension}", File.read!(file), [acl: :public_read])
    |> ExAws.request(region: "us-east-2")

    File.rm(file)
  end
end
