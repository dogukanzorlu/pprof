defmodule Pprof.Servers.Profile do
  use GenServer

  alias Pprof.Builder.FunctionId
  alias Pprof.Builder.LocationId
  alias Pprof.Builder.StringId
  alias Pprof.Builder.Profile
  alias Pprof.Servers.Utils

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :init, name: __MODULE__)
  end

  @impl true
  def init(:init) do
    FunctionId.start_link([])
    LocationId.start_link([])
    StringId.start_link([])
    Profile.start_link([])

    {:ok, :init}
  end

  @impl true
  def handle_call({:profile, type, pid, msec}, _, state) do
    check_pid = if pid == nil, do: self(), else: pid

    case type do
      "fprof" ->
        Utils.fprof(check_pid, msec)
        Utils.flush_agents()

        {:reply, {:ok, nil}, state}

      _ ->
        {:reply, {:error, "type is not supported"}, state}
    end
  end
end
