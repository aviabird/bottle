# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :hawkeye,
  ecto_repos: [Hawkeye.Repo]

# Configures the endpoint
config :hawkeye, HawkeyeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "F13y5YNQv4gsWGmmwkERYWTvFh85SomApOAuRUUhdAAABHULWU1FfYte6oIiry02",
  render_errors: [view: HawkeyeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Hawkeye.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
