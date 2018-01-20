use Mix.Config

config :crypto_monitor2_curso, ecto_repos: [CryptoMonitor2Curso.Repo]

import_config "#{Mix.env}.exs"
