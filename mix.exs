defmodule HabboApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :habbo_api,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {HabboApi, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:poison, "~> 2.2.0 "},
      {:rethinkdb, "~> 0.4.0"},
      {:comeonin, "~> 4.1.2"},
      {:bcrypt_elixir, "~> 1.1.1"},
      {:cors_plug, "~> 2.0"},
      {:nanoid, "~> 2.0.1"},
      {:timex, "~> 3.1"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
