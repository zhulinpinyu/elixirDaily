defmodule CoinPrice.MixProject do
  use Mix.Project

  def project do
    [
      app: :coin_price,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {CoinPrice.Application, []}
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.2"},
      {:jason, "~> 1.1"}
    ]
  end
end
