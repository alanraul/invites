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
      template: invite.template,
      texts: render_many(invite.texts, InvitesView, "texts.json")
    }
  end

  def render("texts.json", %{invites: text}) do
    %{
      id: text.id,
      color: text.color,
      column_width: text.column_width,
      coordinates: text.coordinates,
      font: text.font,
      size: text.size,
      tag: text.tag
    }
  end
end
