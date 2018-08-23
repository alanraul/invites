defmodule InvitesWeb.Router do
  use InvitesWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", InvitesWeb do
    pipe_through :api

    resources "/invites", InvitesController, except: [:edit, :new]
    resources "/invites/:invite/texts", TextsController, except: [:edit, :new, :index]
    resources "/messages", MessagesController, except: [:edit, :new]
  end
end
