defmodule Pprof.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    port = Application.fetch_env!(:pprof, :port)

    children = [
      {Pprof.Servers.Profile, []},
      {Plug.Cowboy, scheme: :http, plug: Pprof.Router, port: port, compress: true}
      # Starts a worker by calling: Pprof.Worker.start_link(arg)
      # {Pprof.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pprof.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
