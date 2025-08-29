# SPDX-License-Identifier: MIT
# Copyright (c) 2025-present K. S. Ernest (iFire) Lee

defmodule AriaTemporalBlocks.MixProject do
  use Mix.Project

  def project do
    [
      app: :aria_temporal_blocks,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps()
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      extra_applications: [:logger],
    ]
  end

  defp deps do
    [
      {:aria_hybrid_planner, git: "https://github.com/V-Sekai-fire/aria-hybrid-planner.git", override: true},
      {:jason, "~> 1.4"},
      {:libgraph, "~> 0.16"},
      {:porcelain, "~> 2.0"},
      {:timex, "~> 3.7"},
      {:telemetry, "~> 1.0"},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end
end
