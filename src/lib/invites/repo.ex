defmodule Invites.Repo do
  use Ecto.Repo, otp_app: :invites

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("PG_INVITES_URL"))}
  end
end
