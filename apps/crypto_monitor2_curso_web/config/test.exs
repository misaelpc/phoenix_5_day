use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :crypto_monitor2_curso_web, CryptoMonitor2CursoWeb.Endpoint,
  http: [port: 4001],
  server: false
