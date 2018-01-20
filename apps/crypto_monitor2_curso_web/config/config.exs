# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :crypto_monitor2_curso_web,
  namespace: CryptoMonitor2CursoWeb,
  ecto_repos: [CryptoMonitor2Curso.Repo]

# Configures the endpoint
config :crypto_monitor2_curso_web, CryptoMonitor2CursoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HONwdIYhu8aA2hbfolewJzV+cReE4mED5eMyeB9iHhrpPPuXuduZZPu/P6ze0qqf",
  render_errors: [view: CryptoMonitor2CursoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CryptoMonitor2CursoWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :crypto_monitor2_curso_web, :generators,
  context_app: :crypto_monitor2_curso

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
