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
