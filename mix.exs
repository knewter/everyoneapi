defmodule Everyoneapi.Mixfile do
  use Mix.Project

  def project do
    [app: :everyoneapi,
     version: "0.0.1",
     description: "API Client for EveryoneAPI.com.",
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.6.0"},
      {:poison,    "~> 1.3.1"},
      {:ex_doc, "0.7.0", only: :docs},
      {:markdown, github: "devinus/markdown", only: :docs}
    ]
  end

  defp package do
    [
      contributors: ["Josh Adams"],
      licenses: ["MIT"],
      links: %{"GitHub" => "http://github.com/knewter/everyoneapi"}
    ]
  end
end
