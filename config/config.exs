use Mix.Config

config :wallaby,
  base_url: "https://revzilla.com/",
  max_wait_time: 5_000,
  js_errors: false
#  driver: Wallaby.Chrome,
#  chromedriver: [
#    binary: "/usr/bin/chromedriver",
#    headless: true
#  ]
