defmodule Pprof.MixProject do
  use Mix.Project

  def project do
    [
      app: :pprof,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  def description do
    """
    `Pprof` serves via its HTTP server fprof profiling data in the format expected by the pprof visualization tools for Elixir.
    """
  end

  defp package do
    [
     files: ["lib", "mix.exs", "README.md"],
     maintainers: ["Dogukan Zorlu"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/dogukanzorlu/pprof",
              "Docs" => "https://hexdocs.pm/pprof/"}
     ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :tools],
      mod: {Pprof.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:protox, "~> 1.6"},
      {:jason, "~> 1.2"},
      {:ex_doc, "~> 0.11", only: :dev},
      {:earmark, "~> 0.1", only: :dev},
      {:dialyxir, "~> 0.3", only: [:dev]}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
