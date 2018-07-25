defmodule InvitesWeb.TextsView do
  use InvitesWeb, :view

  alias InvitesWeb.TextsView

  def render("show.json", %{texts: text}) do
    %{
      errors: nil,
      data: render_one(text, TextsView, "text.json"),
      status: "success"
    }
  end

  def render("text.json", %{texts: text}) do
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
