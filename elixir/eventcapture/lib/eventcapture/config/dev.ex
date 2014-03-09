defmodule Eventcapture.Config.Dev do
  use Eventcapture.Config

  config :router, port: 4000,
                  ssl: false

  config :plugs, code_reload: true

  config :logger, level: :error
end


