defmodule PprofTest do
  use ExUnit.Case
  doctest Pprof

  test "greets the world" do
    assert Pprof.hello() == :world
  end
end
