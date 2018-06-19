defmodule InvitesWeb.Router do
  use InvitesWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", InvitesWeb do
    pipe_through :api

    resources "/invites", InvitesController, except: [:edit, :new]
    resources "/messages", MessagesController, except: [:edit, :new]
  end
end
