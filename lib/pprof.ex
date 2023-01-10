defmodule Pprof do
  @moduledoc """
  `Pprof` serves via its HTTP server fprof profiling data in the format expected by the pprof visualization tools for Elixir.

  `Pprof` basically uses erlang [:fprof](https://www.erlang.org/doc/man/fprof.html) and generates meaningful pprof data from noisy data of fprof profile.


  # Aim
    The observation and profiling culture of erlang and elixir is different from other languages.
    Elixir/Erlang runs on a virtual machine (a.k.a beam) and each block of code represents a process.
    Erlang provides many tools internally for monitoring abstracted processes and processes dependent functions.
    This library produces as meaningful pprof output as possible using the built-in Erlang profiling tools. Thus, it tries to spread the Erlang/Elixir observability with pprof-based ad-hoc profiling tools.

  # A few important things

    - This library an experimental and still under development, a library that needs to be careful to use on the production line.
    - The accuracy of the outputs has been proven by testing with cross-tools. But this alpha version does not offer a full pprof service.
    - fprof significantly slows down the application it is running on. It monitors all processes and collects their tracing data.
      Therefore, even a 10-second data collection in large-scale applications can mean GBs of data.
      It is recommended that the scrape seconds do not exceed 5 in order not to get lost in the abundance of data. More information: [:fprof](https://www.erlang.org/doc/man/fprof.html)


  # Installation and Usage

  ## Installation

      def deps do
        [
          {:pprof, "~> 0.1.0"}
        ]
      end

    After:
      $ mix deps.get

  ## Usage

    Add pprof config your config file like this:

      config :pprof, :port, 8080

    You can use with go pprof:

      go tool pprof http://localhost:8080/debug/pprof/profile?seconds=5&type=fprof

    Also using with [Parca](https://github.com/parca-dev/parca) add configure in parca.yaml:
        # params:
        #   type: [ 'fprof' ]

  # Contributing

  If you are an expert in elixir or erlang and want to contribute, please feel free. Who can say no to better written or more performant code? Thanks in advance for helping and teaching me so much.
  # License

    pprof is released under the [MIT License](https://opensource.org/licenses/MIT).
  """
end
