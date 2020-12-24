defmodule GrpcDemo.MixProject do
  use Mix.Project

  def project do
    [
      app: :grpc_demo,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {GrpcDemo.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:grpc, "~> 0.5.0-beta"},
      {:cowlib, "~> 2.8.0", hex: :grpc_cowlib, override: true}
    ]
  end
end
