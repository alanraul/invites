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
  coordinates: "40,80",
  font: "TypoSlab_demo.otf",
  column_width: 22,
  color: "#000000",
  tag: "event",
  size: 18,
  invite_id: invite.id
})

TextsManager.create(%{
  coordinates: "40,120",
  font: "TypoSlab_demo.otf",
  column_width: 22,
  color: "#000000",
  tag: "celebrated",
  size: 18,
  invite_id: invite.id
})

TextsManager.create(%{
  coordinates: "40,160",
  font: "TypoSlab_demo.otf",
  column_width: 22,
  color: "#000000",
  tag: "place",
  size: 18,
  invite_id: invite.id
})

TextsManager.create(%{
  coordinates: "40,200",
  font: "TypoSlab_demo.otf",
  column_width: 22,
  color: "#000000",
  tag: "date",
  size: 18,
  invite_id: invite.id
})
