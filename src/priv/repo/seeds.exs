# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Invites.Repo.insert!(%Invites.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Invites.Contexts.InvitesManager
alias Invites.Contexts.TextsManager

{:ok, invite} = InvitesManager.create(%{template: "01.png"})

TextsManager.create(%{
  coordinates: "440,240",
  font: "Gotham-Book.otf",
  number_char: 20,
  color: "#11a1e4",
  tag: "event",
  size: 38,
  invite_id: invite.id,
  align: "left"
})

TextsManager.create(%{
  coordinates: "30,380",
  font: "Gotham-Book.otf",
  number_char: 13,
  color: "#2d2fa4",
  tag: "celebrated",
  size: 90,
  invite_id: invite.id
})

TextsManager.create(%{
  coordinates: "180,560",
  font: "Gotham-Book.otf",
  number_char: 28,
  color: "#e3717f",
  tag: "place",
  size: 32,
  invite_id: invite.id
})

TextsManager.create(%{
  coordinates: "180,760",
  font: "Gotham-Book.otf",
  number_char: 30,
  color: "#e3717f",
  tag: "date",
  size: 28,
  invite_id: invite.id
})
