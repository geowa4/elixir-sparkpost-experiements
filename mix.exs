defmodule RocDev.Newsletter.Mixfile do
  use Mix.Project

  def project do
    [
      app: :rocdev_newsletter,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "~> 0.8.0"},
      {:poison, "~> 3.1"},
      {:sparkpost, "~> 0.5.1"}
    ]
  end
end
