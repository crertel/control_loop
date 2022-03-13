defmodule ControlLoop.MixProject do
  use Mix.Project

  def project do
    [
      app: :control_loop,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
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
      {:vega_lite, "~> 0.1.3", only: :dev},
      {:kino, "~> 0.5.0", only: :dev}
    ]
  end
end
