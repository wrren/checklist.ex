use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :checklist, Checklist.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../", __DIR__)]]


# Watch static and templates for browser reloading.
config :checklist, Checklist.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :checklist, Checklist.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "checklist",
  password: "password",
  database: "checklist_dev",
  hostname: "localhost",
  pool_size: 10

config :ueberauth, Ueberauth,
  providers: [
    saml: {Ueberauth.Strategy.SAML, [
      callback_methods:       ["POST"],
      idp_metadata_url:       System.get_env("SAML_IDP_METADATA_URL"),
      private_key:            "priv/saml/saml.pem",
      idp_signs_assertions:   false,
      trusted_fingerprints:   [],
      verify_recipient:       false,
      verify_audience:        false
    ]}
  ]