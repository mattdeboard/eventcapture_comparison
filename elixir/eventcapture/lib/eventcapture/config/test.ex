defmodule Eventcapture.Config.Test do
  use Eventcapture.Config

  config :router, port: 4001,
                  ssl: false

  config :plugs, code_reload: true

  config :logger, level: :debug
end


