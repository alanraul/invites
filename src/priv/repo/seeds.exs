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

InvitesManager.create(%{
  template_uri: "https://s3.us-east-2.amazonaws.com/invites-templates/83SIN.png",
  coordinates: ["40,220"],
  font_uri: "https://s3.us-east-2.amazonaws.com/invites-fonts/TypoSlab_demo.otf",
  font_size: "18",
  column_width: "22",
  color: "0,0,0"
})
