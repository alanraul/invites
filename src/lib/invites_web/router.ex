defmodule InvitesWeb.Router do
  use InvitesWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", InvitesWeb do
    pipe_through :api
  end
end
