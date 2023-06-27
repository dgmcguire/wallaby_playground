use Mix.Config

config :wallaby, base_url: "https://rz.stagezla.com/",
  max_wait_time: 10_000,
  js_errors: false,
  screenshot_dir: "#{File.cwd!}/ss",
  screenshot_on_failure: true,
  chromedriver: [
    headless: false
  ]
