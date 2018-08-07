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
      align: text.align,
      color: text.color,
      coordinates: text.coordinates,
      font: text.font,
      number_char: text.number_char,
      size: text.size,
      spacing: text.spacing,
      tag: text.tag
    }
  end
end
