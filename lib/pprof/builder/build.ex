defmodule Pprof.Builder.Build do
  alias Pprof.Builder.FunctionId
  alias Pprof.Builder.LocationId
  alias Pprof.Builder.StringId
  alias Pprof.Builder.Profile

  def builder(duration) do
    {_, terms} = :file.consult('/tmp/profile.fprof')
    res = process_terms(terms, duration)

    case res do
      {:process_terms, resp} ->
        resp
    end
  end

  def process_terms([], _opts) do
    {:ok, iodata} = Protox.encode(Profile.get_all(Profile))
    compressed = :zlib.gzip(iodata)
    {:process_terms, compressed}
  end

  def process_terms([{_analysis_options, _} | rest], duration) do
    get_string_id("")

    Profile.put(Profile, :period_type, %Perftools.Profiles.ValueType{
      type: get_string_id("CPU"),
      unit: get_string_id("nanoseconds")
    })

    Profile.put(Profile, :period, 10_000 * 1000 * 1000)
    Profile.put(Profile, :time_nanos, :os.system_time(:nanosecond))
    Profile.put(Profile, :duration_nanos, duration * 1000 * 1000)

    set_list_to_profile(:sample_type, %Perftools.Profiles.ValueType{
      type: get_string_id("sample"),
      unit: get_string_id("count")
    })

    set_list_to_profile(:sample_type, %Perftools.Profiles.ValueType{
      type: get_string_id("CPU"),
      unit: get_string_id("nanoseconds")
    })

    process_terms(rest, duration)
  end

  def process_terms([[{pid, _Cnt, _Acc, _Own} | _T] | rest], duration) when is_list(pid) do
    process_terms(rest, duration)
  end

  def process_terms([list | rest], duration) when is_list(list) do
    process_terms(rest, duration)
  end

  def process_terms([entry | rest], duration) do
    process_entry(entry)
    process_terms(rest, duration)
  end

  def process_entry({_CallingList, actual, called_list}) do
    if(Enum.count(called_list) != 0) do
      merged_list =
        Enum.concat([actual], called_list)
        |> Enum.reverse()

      time = actual_time(merged_list |> List.first())

      loc_ids =
        merged_list
        |> Enum.map(fn {mod, _, _, _} ->
          func_id = get_function_id("#{inspect(mod)}", to_string(inspect(mod)))
          ids = get_location_id(func_id, 1)
          ids
        end)

      set_list_to_profile(:sample, %Perftools.Profiles.Sample{
        location_id: loc_ids,
        value: [1, time]
      })
    end
  end

  def actual_time({:suspend, _, acc, _}) do
    Kernel.trunc(acc * 1000 * 1000)
  end

  def actual_time({_, _, _, own}) do
    Kernel.trunc(own * 1000 * 1000)
  end

  def get_string_id(value) do
    string_id = StringId.get(StringId, value)

    case string_id do
      nil ->
        size = StringId.size(StringId)

        StringId.put(StringId, value, size)

        set_list_to_profile(:string_table, value)

        size

      _ ->
        string_id
    end
  end

  def get_function_id(name, filename) do
    name_id = get_string_id(name)
    filename_id = get_string_id(filename)

    function = {name_id, filename_id}
    func_id = FunctionId.get(FunctionId, function)

    case func_id do
      nil ->
        size = FunctionId.size(FunctionId) + 1

        FunctionId.put(FunctionId, function, size)

        value = %Perftools.Profiles.Function{name: name_id, filename: filename_id, id: size}
        set_list_to_profile(:function, value)

        size

      _ ->
        func_id
    end
  end

  def get_location_id(func_id, line) do
    location = {func_id, line}
    location_id = LocationId.get(LocationId, location)

    case location_id do
      nil ->
        size = LocationId.size(LocationId) + 1

        LocationId.put(LocationId, location, size)

        line_perf = %Perftools.Profiles.Line{function_id: func_id, line: line}
        value = %Perftools.Profiles.Location{id: size, line: [line_perf]}
        set_list_to_profile(:location, value)

        size

      _ ->
        location_id
    end
  end

  defp set_list_to_profile(key, value) do
    current_value = Profile.get(Profile, key)

    Profile.put(Profile, key, Enum.concat(current_value, [value]))
  end
end
