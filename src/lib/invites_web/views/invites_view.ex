defmodule InvitesWeb.InvitesView do
  use InvitesWeb, :view

  alias InvitesWeb.InvitesView

  def render("index.json", %{invites: invites}) do
    %{
      errors: nil,
      data: render_many(invites, InvitesView, "invite.json"),
      status: "success"
    }
  end

  def render("show.json", %{invite: invite}) do
    %{
      errors: nil,
      data: render_one(invite, InvitesView, "invite.json"),
      status: "success"
    }
  end

  def render("invite.json", %{invites: invite}) do
    %{
      id: invite.id,
      template_uri: invite.template_uri,
      coordinates: invite.coordinates,
      font_uri: invite.font_uri,
      font_size: invite.font_size,
      column_width: invite.column_width,
      color: invite.color
    }
  end
end
