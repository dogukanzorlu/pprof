defmodule Pprof.Servers.Utils do
  alias Pprof.Builder.FunctionId
  alias Pprof.Builder.LocationId
  alias Pprof.Builder.StringId
  alias Pprof.Builder.Profile

  def flush_agents() do
    FunctionId.flush(FunctionId)
    LocationId.flush(LocationId)
    StringId.flush(StringId)
    Profile.flush(Profile)
  end

  def fprof(_pid, msecs) do
    :fprof.trace([:start, verbose: true, procs: :all])
    Process.sleep(msecs)
    :fprof.trace(:stop)
    :fprof.profile()
    :fprof.analyse({:dest, '/tmp/profile.fprof'})
  end
end
