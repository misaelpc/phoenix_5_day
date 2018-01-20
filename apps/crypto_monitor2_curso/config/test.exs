use Mix.Config

# Configure your database
config :crypto_monitor2_curso, CryptoMonitor2Curso.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "crypto_monitor2_curso_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
