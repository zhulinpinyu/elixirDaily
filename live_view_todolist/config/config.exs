# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :live_view_todolist,
  ecto_repos: [LiveViewTodolist.Repo]

# Configures the endpoint
config :live_view_todolist, LiveViewTodolistWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/wsfcJN4rff0T3xye4kbJfNr8GFrfmxAk3rTPHqdogvKJNiDKpbNqoukOkl6vrgC",
  render_errors: [view: LiveViewTodolistWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LiveViewTodolist.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "zkFqL3Lx8nc4JycmX76xZ2GlNHV8LJlR"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix,
  json_library: Jason,
  template_engines: [leex: Phoenix.LiveView.Engine]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
