use Mix.Config

# For production, we often load configuration from external
# sources, such as your system environment. For this reason,
# you won't find the :http configuration below, but set inside
# InvitesWeb.Endpoint.init/2 when load_from_system_env is
# true. Any dynamic configuration should be done there.
#
# Don't forget to configure the url host to something meaningful,
# Phoenix uses this information when generating URLs.
#
# Finally, we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the mix phx.digest task
# which you typically run after static files are built.
config :invites, InvitesWeb.Endpoint,
	http: [port: "${PHX_PORT}"],
  url: [host: "${PHX_URL}"],
  secret_key_base: "${PHX_SECRET_KEY_BASE}",
  server: true,
  root: ".",
  version: Mix.Project.config[:version]

# Do not print debug messages in production
config :logger, level: :info

# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section and set your `:url` port to 443:
#
#     config :invites, InvitesWeb.Endpoint,
#       ...
#       url: [host: "example.com", port: 443],
#       https: [:inet6,
#               port: 443,
#               keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#               certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables return an absolute path to
# the key and cert in disk or a relative path inside priv,
# for example "priv/ssl/server.key".
#
# We also recommend setting `force_ssl`, ensuring no data is
# ever sent via http, always redirecting to https:
#
#     config :invites, InvitesWeb.Endpoint,
#       force_ssl: [hsts: true]
#
# Check `Plug.SSL` for all available options in `force_ssl`.

# ## Using releases
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start the server for all endpoints:
#
#     config :phoenix, :serve_endpoints, true
#
# Alternatively, you can configure exactly which server to
# start per endpoint:
#
#     config :invites, InvitesWeb.Endpoint, server: true
#

# Finally import the config/prod.secret.exs
# which should be versioned separately.

config :invites, Invites.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "${PG_INVITES_URL}",
  pool_size: 20,
  ssl: true

config :invites, :ex_aws,
  access_key_id: [
    {:system, "${AWS_ACCESS_KEY_ID}"},
    :instance_role
  ],
  secret_access_key: [
    {:system, "${AWS_SECRET_ACCESS_KEY}"},
    :instance_role
  ]

config :invites, :buckets,
  fonts: "${FONTS_BUCKET}",
  messages: "${MESSAGES_BUCKET}"