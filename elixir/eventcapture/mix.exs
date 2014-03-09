defmodule Eventcapture.Mixfile do
  use Mix.Project

  def project do
    [ app: :eventcapture,
      version: "0.0.1",
      elixir: "~> 0.12.4",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ mod: { Eventcapture.App, [] }]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      {:phoenix, github: "phoenixframework/phoenix"},
      {:ecto, github: "elixir-lang/ecto"},
      {:postgrex, github: "ericmj/postgrex"},
      {:plug, github: "elixir-lang/plug"},
      {:httpotion, github: "myfreeweb/httpotion"},
      {:json, github: "cblage/elixir-json"}
    ]
  end
end
