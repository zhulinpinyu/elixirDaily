defmodule CurrentCurrency.MixProject do
  use Mix.Project

  def project do
    [
      app: :current_currency,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {CurrentCurrency.Application, []}
    ]
  end

  defp deps do
    [
      {:cowboy, "~> 2.4"},
      {:plug, "~> 1.6"},
      {:httpoison, "~> 1.2"},
      {:jason, "~> 1.0"}
    ]
  end
end
