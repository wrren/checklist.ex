# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :checklist,
  ecto_repos: [Checklist.Repo]

# Configures the endpoint
config :checklist, Checklist.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "m2FNQcGX7iJPVleocWD07XoUdUH+laqLwCnFZE63ojwEhyR/lhdOEkR99G4tQggJ",
  render_errors: [view: Checklist.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Checklist.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
