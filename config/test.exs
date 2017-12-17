use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gym_rat, GymRatWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :gym_rat, GymRat.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "gym_rat_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
