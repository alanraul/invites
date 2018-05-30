use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :invites, InvitesWeb.Endpoint,
  http: [port: 4001],
  secret_key_base: "heHHS6mHR4TgKlgWrTVip+wAyK5AbFSY+ytSEnkWD4D8CG/QVwfUw3Coj/hlNcQL",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :invites, Invites.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "invites_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
