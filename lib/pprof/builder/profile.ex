defmodule Pprof.Builder.Profile do
  use Agent

  @doc """
  Starts a new bucket.
  """
  def start_link(_opts) do
    Agent.start_link(fn -> %Perftools.Profiles.Profile{} end, name: __MODULE__)
  end

  @doc """
  Gets a value from the `bucket` by `key`.
  """
  def get(bucket, key) do
    Agent.get(bucket, &Map.get(&1, key))
  end

  def get_all(bucket) do
    Agent.get(bucket, fn state -> state end)
  end

  @doc """
  Puts the `value` for the given `key` in the `bucket`.
  """
  def put(bucket, key, value) do
    Agent.update(bucket, &Map.put(&1, key, value))
  end

  def flush(bucket) do
    Agent.update(bucket, fn _ -> %Perftools.Profiles.Profile{} end)
  end

  @doc """
  Get the size of `bucket`.
  """
  def size(bucket) do
    Agent.get(bucket, &Enum.count/1)
  end
end
