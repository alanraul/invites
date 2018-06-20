defmodule InvitesWeb.MessagesController do
  use InvitesWeb, :controller

  alias Invites.Contexts.InvitesManager

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
        fonts_bucket = Application.get_env(:invites, :buckets)[:fonts]
        font = "https://s3.us-east-2.amazonaws.com/invites-app/#{message_params["font"]}"
        path_script = "#{System.cwd()}/pillow"

        {"", 0} = System.cmd(path_script, [invite.uri, font, message_params["text"]])

        ExAws.S3.put_object("invites-app", "output.jpg", File.read!("#{System.cwd()}/output.jpg"),  [acl: :public_read])
        |> ExAws.request(region: "us-east-2")

        message = %{
          uri: "https://s3.us-east-2.amazonaws.com/invites-app/output.jpg"
        }
        render(conn, "message.json", message: message)
    end
  end
end
