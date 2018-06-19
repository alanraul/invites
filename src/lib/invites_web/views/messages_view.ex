defmodule InvitesWeb.MessagesView do
  use InvitesWeb, :view

  def render("message.json", %{message: message}) do
    %{
      uri: message.uri
    }
  end
end
