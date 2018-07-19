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

{:ok, invite} = InvitesManager.create(%{
  template: "https://s3.us-east-2.amazonaws.com/invites-templates/01.png",
})

TextsManager.create(%{
  coordinates: "40,220",
  font: "https://s3.us-east-2.amazonaws.com/invites-fonts/TypoSlab_demo.otf",
  column_width: "22",
  color: "#000",
  tag: "event",
  size: "18",
  invite_id: invite.id
})
