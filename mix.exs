defmodule Recurse.MixProject do
  use Mix.Project

  @source_url "https://github.com/carloshsf/recurse"

  def project do
    [
      app: :recurse,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Recurse",
      description: "Explicit recursion inside functions with a recursive block.",
      package: package(),
      docs: docs()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
    ]
  end

  defp package do
    [
      licenses: ["GPL-3.0-only"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      source_url: @source_url,
    ]
  end
end
