defmodule InvitesWeb.MessagesController do
  use InvitesWeb, :controller

  alias Invites.Contexts.InvitesManager

  require Logger

  @doc """
  Añade un mensaje al template de una invitación.
  """
  @spec create(map, map):: map
  def create(conn, %{"message" => %{"invite_id" => id, "text" => text}}) do
    case InvitesManager.get(id) do
      nil ->
        render(conn, ErrorView, "404.json")
      invite ->
        IO.inspect("===============================================")
        #IO.inspect ExAws.S3.list_objects("invites-app") |> ExAws.request(region: "us-east-2")

        font = "https://s3.us-east-2.amazonaws.com/invites-app/test.otf"
        path = "#{System.cwd()}/pillow"

        {"", 0} = System.cmd(path, [invite.uri, font, text])
        IO.inspect(File.read!("#{System.cwd()}/output.jpg"))
        ExAws.S3.put_object("invites-app", "output.jpg", File.read!("#{System.cwd()}/output.jpg"),  [acl: :public_read])
        |> ExAws.request(region: "us-east-2")
        |> IO.inspect()

        message = %{
          uri: "https://s3.us-east-2.amazonaws.com/invites-app/output.jpg"
        }
        render(conn, "message.json", message: message)
    end
  end
end
