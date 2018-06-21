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
  uri: "https://s3.us-east-2.amazonaws.com/invites-templates/83SIN.png",
  coordinates: "40,220"
})
