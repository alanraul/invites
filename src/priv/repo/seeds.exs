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
  coordinates: "140,90",
  font: "Gotham-Book.otf",
  number_char: 22,
  color: "#11a1e4",
  tag: "event",
  size: 18,
  invite_id: invite.id
})

TextsManager.create(%{
  coordinates: "30,120",
  font: "Gotham-Book.otf",
  number_char: 22,
  color: "#2d2fa4",
  tag: "celebrated",
  size: 60,
  invite_id: invite.id
})

TextsManager.create(%{
  coordinates: "70,260",
  font: "Gotham-Book.otf",
  number_char: 12,
  color: "#e3717f",
  tag: "place",
  size: 18,
  invite_id: invite.id
})

TextsManager.create(%{
  coordinates: "50,200",
  font: "Gotham-Book.otf",
  number_char: 17,
  color: "#e3717f",
  tag: "date",
  size: 18,
  invite_id: invite.id
})
