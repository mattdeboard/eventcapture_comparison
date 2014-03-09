defmodule Eventcapture.Config.Dev do
  use Eventcapture.Config

  config :router, port: 3000,
                  ssl: false

  config :plugs, code_reload: false

  config :logger, level: :error
end


