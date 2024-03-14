import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :daimon_date_picker, DaimonDatePickerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "fYF9buF2UhgWft7preXhFu6rZKOC7DINXgqkVaRb/fSpgmB7KAr0KWLTzfHK+duC",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
