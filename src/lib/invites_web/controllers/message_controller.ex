defmodule InvitesWeb.MessagesController do
  use InvitesWeb, :controller

  alias Invites.Contexts.InvitesManager
  alias ExAws.S3

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

        font = "https://s3.us-east-2.amazonaws.com/invites-fonts/#{message_params["font"]}"
        path_script = "#{System.cwd()}/pillow"
        file_name = Ecto.UUID.generate()

        {"", 0} = System.cmd(
          path_script,
          [invite.uri, font, invite.coordinates, message_params["text"], file_name]
        )

        upload_file(file_name)

        message = %{
          uri: "https://s3.us-east-2.amazonaws.com/invites-messages/#{file_name}.jpg"
        }
        render(conn, "message.json", message: message)
    end
  end

  def upload_file(file_name) do
    file = "#{System.cwd()}/#{file_name}.jpg"

    Application.get_env(:invites, :buckets)[:messages]
    |> S3.put_object("#{file_name}.jpg", File.read!(file), [acl: :public_read])
    |> ExAws.request(region: "us-east-2")

    File.rm(file)
  end
end
