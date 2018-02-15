# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :rtr, Rtr.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MkFdXdlIHNplGGKszAXGbJdkfrcRqanAEL1FXUWXl1/0J79BGbQYAm5hx0iZi9ld",
  render_errors: [view: Rtr.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Rtr.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.

config :drab,
  main_phoenix_app: :drab_example
import_config "#{Mix.env}.exs"
