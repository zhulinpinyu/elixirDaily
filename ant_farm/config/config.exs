# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ant_farm,
  ecto_repos: [AntFarm.Repo]

# Configures the endpoint
config :ant_farm, AntFarmWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Y33sa4kbGjm8jVH4hc0UMcm8fpGjIVxKH/46lPmytsAr7xy9hc+tmRZez2NeED4i",
  render_errors: [view: AntFarmWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AntFarm.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "pKti8RELFFS/ozc7nfinBlKjizrnq3fA"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix,
  json_library: Jason,
  template_engines: [leex: Phoenix.LiveView.Engine]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
