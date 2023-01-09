# credo:disable-for-this-file
[
  defmodule Perftools.Profiles.Function do
    @moduledoc false
    defstruct id: 0, name: 0, system_name: 0, filename: 0, start_line: 0, __uf__: []

    (
      (
        @spec encode(struct) :: {:ok, iodata} | {:error, any}
        def encode(msg) do
          try do
            {:ok, encode!(msg)}
          rescue
            e in [Protox.EncodingError, Protox.RequiredFieldsError] -> {:error, e}
          end
        end

        @spec encode!(struct) :: iodata | no_return
        def encode!(msg) do
          []
          |> encode_id(msg)
          |> encode_name(msg)
          |> encode_system_name(msg)
          |> encode_filename(msg)
          |> encode_start_line(msg)
          |> encode_unknown_fields(msg)
        end
      )

      []

      [
        defp encode_id(acc, msg) do
          try do
            if msg.id == 0 do
              acc
            else
              [acc, "\b", Protox.Encode.encode_uint64(msg.id)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:id, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_name(acc, msg) do
          try do
            if msg.name == 0 do
              acc
            else
              [acc, "\x10", Protox.Encode.encode_int64(msg.name)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:name, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_system_name(acc, msg) do
          try do
            if msg.system_name == 0 do
              acc
            else
              [acc, "\x18", Protox.Encode.encode_int64(msg.system_name)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:system_name, "invalid field value"),
                      __STACKTRACE__
          end
        end,
        defp encode_filename(acc, msg) do
          try do
            if msg.filename == 0 do
              acc
            else
              [acc, " ", Protox.Encode.encode_int64(msg.filename)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:filename, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_start_line(acc, msg) do
          try do
            if msg.start_line == 0 do
              acc
            else
              [acc, "(", Protox.Encode.encode_int64(msg.start_line)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:start_line, "invalid field value"), __STACKTRACE__
          end
        end
      ]

      defp encode_unknown_fields(acc, msg) do
        Enum.reduce(msg.__struct__.unknown_fields(msg), acc, fn {tag, wire_type, bytes}, acc ->
          case wire_type do
            0 ->
              [acc, Protox.Encode.make_key_bytes(tag, :int32), bytes]

            1 ->
              [acc, Protox.Encode.make_key_bytes(tag, :double), bytes]

            2 ->
              len_bytes = bytes |> byte_size() |> Protox.Varint.encode()
              [acc, Protox.Encode.make_key_bytes(tag, :packed), len_bytes, bytes]

            5 ->
              [acc, Protox.Encode.make_key_bytes(tag, :float), bytes]
          end
        end)
      end
    )

    (
      (
        @spec decode(binary) :: {:ok, struct} | {:error, any}
        def decode(bytes) do
          try do
            {:ok, decode!(bytes)}
          rescue
            e in [Protox.DecodingError, Protox.IllegalTagError, Protox.RequiredFieldsError] ->
              {:error, e}
          end
        end

        (
          @spec decode!(binary) :: struct | no_return
          def decode!(bytes) do
            parse_key_value(bytes, struct(Perftools.Profiles.Function))
          end
        )
      )

      (
        @spec parse_key_value(binary, struct) :: struct
        defp parse_key_value(<<>>, msg) do
          msg
        end

        defp parse_key_value(bytes, msg) do
          {field, rest} =
            case Protox.Decode.parse_key(bytes) do
              {0, _, _} ->
                raise %Protox.IllegalTagError{}

              {1, _, bytes} ->
                {value, rest} = Protox.Decode.parse_uint64(bytes)
                {[id: value], rest}

              {2, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[name: value], rest}

              {3, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[system_name: value], rest}

              {4, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[filename: value], rest}

              {5, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[start_line: value], rest}

              {tag, wire_type, rest} ->
                {value, rest} = Protox.Decode.parse_unknown(tag, wire_type, rest)

                {[
                   {msg.__struct__.unknown_fields_name,
                    [value | msg.__struct__.unknown_fields(msg)]}
                 ], rest}
            end

          msg_updated = struct(msg, field)
          parse_key_value(rest, msg_updated)
        end
      )

      []
    )

    (
      @spec json_decode(iodata(), keyword()) :: {:ok, struct()} | {:error, any()}
      def json_decode(input, opts \\ []) do
        try do
          {:ok, json_decode!(input, opts)}
        rescue
          e in Protox.JsonDecodingError -> {:error, e}
        end
      end

      @spec json_decode!(iodata(), keyword()) :: struct() | no_return()
      def json_decode!(input, opts \\ []) do
        {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :decode)

        Protox.JsonDecode.decode!(
          input,
          Perftools.Profiles.Function,
          &json_library_wrapper.decode!(json_library, &1)
        )
      end

      @spec json_encode(struct(), keyword()) :: {:ok, iodata()} | {:error, any()}
      def json_encode(msg, opts \\ []) do
        try do
          {:ok, json_encode!(msg, opts)}
        rescue
          e in Protox.JsonEncodingError -> {:error, e}
        end
      end

      @spec json_encode!(struct(), keyword()) :: iodata() | no_return()
      def json_encode!(msg, opts \\ []) do
        {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :encode)
        Protox.JsonEncode.encode!(msg, &json_library_wrapper.encode!(json_library, &1))
      end
    )

    (
      @deprecated "Use fields_defs()/0 instead"
      @spec defs() :: %{
              required(non_neg_integer) => {atom, Protox.Types.kind(), Protox.Types.type()}
            }
      def defs() do
        %{
          1 => {:id, {:scalar, 0}, :uint64},
          2 => {:name, {:scalar, 0}, :int64},
          3 => {:system_name, {:scalar, 0}, :int64},
          4 => {:filename, {:scalar, 0}, :int64},
          5 => {:start_line, {:scalar, 0}, :int64}
        }
      end

      @deprecated "Use fields_defs()/0 instead"
      @spec defs_by_name() :: %{
              required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
            }
      def defs_by_name() do
        %{
          filename: {4, {:scalar, 0}, :int64},
          id: {1, {:scalar, 0}, :uint64},
          name: {2, {:scalar, 0}, :int64},
          start_line: {5, {:scalar, 0}, :int64},
          system_name: {3, {:scalar, 0}, :int64}
        }
      end
    )

    (
      @spec fields_defs() :: list(Protox.Field.t())
      def fields_defs() do
        [
          %{
            __struct__: Protox.Field,
            json_name: "id",
            kind: {:scalar, 0},
            label: :optional,
            name: :id,
            tag: 1,
            type: :uint64
          },
          %{
            __struct__: Protox.Field,
            json_name: "name",
            kind: {:scalar, 0},
            label: :optional,
            name: :name,
            tag: 2,
            type: :int64
          },
          %{
            __struct__: Protox.Field,
            json_name: "systemName",
            kind: {:scalar, 0},
            label: :optional,
            name: :system_name,
            tag: 3,
            type: :int64
          },
          %{
            __struct__: Protox.Field,
            json_name: "filename",
            kind: {:scalar, 0},
            label: :optional,
            name: :filename,
            tag: 4,
            type: :int64
          },
          %{
            __struct__: Protox.Field,
            json_name: "startLine",
            kind: {:scalar, 0},
            label: :optional,
            name: :start_line,
            tag: 5,
            type: :int64
          }
        ]
      end

      [
        @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
        (
          def field_def(:id) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "id",
               kind: {:scalar, 0},
               label: :optional,
               name: :id,
               tag: 1,
               type: :uint64
             }}
          end

          def field_def("id") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "id",
               kind: {:scalar, 0},
               label: :optional,
               name: :id,
               tag: 1,
               type: :uint64
             }}
          end

          []
        ),
        (
          def field_def(:name) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "name",
               kind: {:scalar, 0},
               label: :optional,
               name: :name,
               tag: 2,
               type: :int64
             }}
          end

          def field_def("name") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "name",
               kind: {:scalar, 0},
               label: :optional,
               name: :name,
               tag: 2,
               type: :int64
             }}
          end

          []
        ),
        (
          def field_def(:system_name) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "systemName",
               kind: {:scalar, 0},
               label: :optional,
               name: :system_name,
               tag: 3,
               type: :int64
             }}
          end

          def field_def("systemName") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "systemName",
               kind: {:scalar, 0},
               label: :optional,
               name: :system_name,
               tag: 3,
               type: :int64
             }}
          end

          def field_def("system_name") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "systemName",
               kind: {:scalar, 0},
               label: :optional,
               name: :system_name,
               tag: 3,
               type: :int64
             }}
          end
        ),
        (
          def field_def(:filename) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "filename",
               kind: {:scalar, 0},
               label: :optional,
               name: :filename,
               tag: 4,
               type: :int64
             }}
          end

          def field_def("filename") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "filename",
               kind: {:scalar, 0},
               label: :optional,
               name: :filename,
               tag: 4,
               type: :int64
             }}
          end

          []
        ),
        (
          def field_def(:start_line) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "startLine",
               kind: {:scalar, 0},
               label: :optional,
               name: :start_line,
               tag: 5,
               type: :int64
             }}
          end

          def field_def("startLine") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "startLine",
               kind: {:scalar, 0},
               label: :optional,
               name: :start_line,
               tag: 5,
               type: :int64
             }}
          end

          def field_def("start_line") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "startLine",
               kind: {:scalar, 0},
               label: :optional,
               name: :start_line,
               tag: 5,
               type: :int64
             }}
          end
        ),
        def field_def(_) do
          {:error, :no_such_field}
        end
      ]
    )

    (
      @spec unknown_fields(struct) :: [{non_neg_integer, Protox.Types.tag(), binary}]
      def unknown_fields(msg) do
        msg.__uf__
      end

      @spec unknown_fields_name() :: :__uf__
      def unknown_fields_name() do
        :__uf__
      end

      @spec clear_unknown_fields(struct) :: struct
      def clear_unknown_fields(msg) do
        struct!(msg, [{unknown_fields_name(), []}])
      end
    )

    (
      @spec required_fields() :: []
      def required_fields() do
        []
      end
    )

    (
      @spec syntax() :: atom()
      def syntax() do
        :proto3
      end
    )

    [
      @spec(default(atom) :: {:ok, boolean | integer | String.t() | float} | {:error, atom}),
      def default(:id) do
        {:ok, 0}
      end,
      def default(:name) do
        {:ok, 0}
      end,
      def default(:system_name) do
        {:ok, 0}
      end,
      def default(:filename) do
        {:ok, 0}
      end,
      def default(:start_line) do
        {:ok, 0}
      end,
      def default(_) do
        {:error, :no_such_field}
      end
    ]

    (
      @spec file_options() :: struct()
      def file_options() do
        file_options = %{
          __struct__: Protox.Google.Protobuf.FileOptions,
          __uf__: [],
          cc_enable_arenas: nil,
          cc_generic_services: nil,
          csharp_namespace: nil,
          deprecated: nil,
          go_package: nil,
          java_generate_equals_and_hash: nil,
          java_generic_services: nil,
          java_multiple_files: nil,
          java_outer_classname: "ProfileProto",
          java_package: "com.google.perftools.profiles",
          java_string_check_utf8: nil,
          objc_class_prefix: nil,
          optimize_for: nil,
          php_class_prefix: nil,
          php_generic_services: nil,
          php_metadata_namespace: nil,
          php_namespace: nil,
          py_generic_services: nil,
          ruby_package: nil,
          swift_prefix: nil,
          uninterpreted_option: []
        }

        case function_exported?(Google.Protobuf.FileOptions, :decode!, 1) do
          true ->
            bytes =
              file_options
              |> Protox.Google.Protobuf.FileOptions.encode!()
              |> :binary.list_to_bin()

            apply(Google.Protobuf.FileOptions, :decode!, [bytes])

          false ->
            file_options
        end
      end
    )
  end,
  defmodule Perftools.Profiles.Label do
    @moduledoc false
    defstruct key: 0, str: 0, num: 0, num_unit: 0, __uf__: []

    (
      (
        @spec encode(struct) :: {:ok, iodata} | {:error, any}
        def encode(msg) do
          try do
            {:ok, encode!(msg)}
          rescue
            e in [Protox.EncodingError, Protox.RequiredFieldsError] -> {:error, e}
          end
        end

        @spec encode!(struct) :: iodata | no_return
        def encode!(msg) do
          []
          |> encode_key(msg)
          |> encode_str(msg)
          |> encode_num(msg)
          |> encode_num_unit(msg)
          |> encode_unknown_fields(msg)
        end
      )

      []

      [
        defp encode_key(acc, msg) do
          try do
            if msg.key == 0 do
              acc
            else
              [acc, "\b", Protox.Encode.encode_int64(msg.key)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:key, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_str(acc, msg) do
          try do
            if msg.str == 0 do
              acc
            else
              [acc, "\x10", Protox.Encode.encode_int64(msg.str)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:str, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_num(acc, msg) do
          try do
            if msg.num == 0 do
              acc
            else
              [acc, "\x18", Protox.Encode.encode_int64(msg.num)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:num, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_num_unit(acc, msg) do
          try do
            if msg.num_unit == 0 do
              acc
            else
              [acc, " ", Protox.Encode.encode_int64(msg.num_unit)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:num_unit, "invalid field value"), __STACKTRACE__
          end
        end
      ]

      defp encode_unknown_fields(acc, msg) do
        Enum.reduce(msg.__struct__.unknown_fields(msg), acc, fn {tag, wire_type, bytes}, acc ->
          case wire_type do
            0 ->
              [acc, Protox.Encode.make_key_bytes(tag, :int32), bytes]

            1 ->
              [acc, Protox.Encode.make_key_bytes(tag, :double), bytes]

            2 ->
              len_bytes = bytes |> byte_size() |> Protox.Varint.encode()
              [acc, Protox.Encode.make_key_bytes(tag, :packed), len_bytes, bytes]

            5 ->
              [acc, Protox.Encode.make_key_bytes(tag, :float), bytes]
          end
        end)
      end
    )

    (
      (
        @spec decode(binary) :: {:ok, struct} | {:error, any}
        def decode(bytes) do
          try do
            {:ok, decode!(bytes)}
          rescue
            e in [Protox.DecodingError, Protox.IllegalTagError, Protox.RequiredFieldsError] ->
              {:error, e}
          end
        end

        (
          @spec decode!(binary) :: struct | no_return
          def decode!(bytes) do
            parse_key_value(bytes, struct(Perftools.Profiles.Label))
          end
        )
      )

      (
        @spec parse_key_value(binary, struct) :: struct
        defp parse_key_value(<<>>, msg) do
          msg
        end

        defp parse_key_value(bytes, msg) do
          {field, rest} =
            case Protox.Decode.parse_key(bytes) do
              {0, _, _} ->
                raise %Protox.IllegalTagError{}

              {1, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[key: value], rest}

              {2, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[str: value], rest}

              {3, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[num: value], rest}

              {4, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[num_unit: value], rest}

              {tag, wire_type, rest} ->
                {value, rest} = Protox.Decode.parse_unknown(tag, wire_type, rest)

                {[
                   {msg.__struct__.unknown_fields_name,
                    [value | msg.__struct__.unknown_fields(msg)]}
                 ], rest}
            end

          msg_updated = struct(msg, field)
          parse_key_value(rest, msg_updated)
        end
      )

      []
    )

    (
      @spec json_decode(iodata(), keyword()) :: {:ok, struct()} | {:error, any()}
      def json_decode(input, opts \\ []) do
        try do
          {:ok, json_decode!(input, opts)}
        rescue
          e in Protox.JsonDecodingError -> {:error, e}
        end
      end

      @spec json_decode!(iodata(), keyword()) :: struct() | no_return()
      def json_decode!(input, opts \\ []) do
        {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :decode)

        Protox.JsonDecode.decode!(
          input,
          Perftools.Profiles.Label,
          &json_library_wrapper.decode!(json_library, &1)
        )
      end

      @spec json_encode(struct(), keyword()) :: {:ok, iodata()} | {:error, any()}
      def json_encode(msg, opts \\ []) do
        try do
          {:ok, json_encode!(msg, opts)}
        rescue
          e in Protox.JsonEncodingError -> {:error, e}
        end
      end

      @spec json_encode!(struct(), keyword()) :: iodata() | no_return()
      def json_encode!(msg, opts \\ []) do
        {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :encode)
        Protox.JsonEncode.encode!(msg, &json_library_wrapper.encode!(json_library, &1))
      end
    )

    (
      @deprecated "Use fields_defs()/0 instead"
      @spec defs() :: %{
              required(non_neg_integer) => {atom, Protox.Types.kind(), Protox.Types.type()}
            }
      def defs() do
        %{
          1 => {:key, {:scalar, 0}, :int64},
          2 => {:str, {:scalar, 0}, :int64},
          3 => {:num, {:scalar, 0}, :int64},
          4 => {:num_unit, {:scalar, 0}, :int64}
        }
      end

      @deprecated "Use fields_defs()/0 instead"
      @spec defs_by_name() :: %{
              required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
            }
      def defs_by_name() do
        %{
          key: {1, {:scalar, 0}, :int64},
          num: {3, {:scalar, 0}, :int64},
          num_unit: {4, {:scalar, 0}, :int64},
          str: {2, {:scalar, 0}, :int64}
        }
      end
    )

    (
      @spec fields_defs() :: list(Protox.Field.t())
      def fields_defs() do
        [
          %{
            __struct__: Protox.Field,
            json_name: "key",
            kind: {:scalar, 0},
            label: :optional,
            name: :key,
            tag: 1,
            type: :int64
          },
          %{
            __struct__: Protox.Field,
            json_name: "str",
            kind: {:scalar, 0},
            label: :optional,
            name: :str,
            tag: 2,
            type: :int64
          },
          %{
            __struct__: Protox.Field,
            json_name: "num",
            kind: {:scalar, 0},
            label: :optional,
            name: :num,
            tag: 3,
            type: :int64
          },
          %{
            __struct__: Protox.Field,
            json_name: "numUnit",
            kind: {:scalar, 0},
            label: :optional,
            name: :num_unit,
            tag: 4,
            type: :int64
          }
        ]
      end

      [
        @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
        (
          def field_def(:key) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "key",
               kind: {:scalar, 0},
               label: :optional,
               name: :key,
               tag: 1,
               type: :int64
             }}
          end

          def field_def("key") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "key",
               kind: {:scalar, 0},
               label: :optional,
               name: :key,
               tag: 1,
               type: :int64
             }}
          end

          []
        ),
        (
          def field_def(:str) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "str",
               kind: {:scalar, 0},
               label: :optional,
               name: :str,
               tag: 2,
               type: :int64
             }}
          end

          def field_def("str") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "str",
               kind: {:scalar, 0},
               label: :optional,
               name: :str,
               tag: 2,
               type: :int64
             }}
          end

          []
        ),
        (
          def field_def(:num) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "num",
               kind: {:scalar, 0},
               label: :optional,
               name: :num,
               tag: 3,
               type: :int64
             }}
          end

          def field_def("num") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "num",
               kind: {:scalar, 0},
               label: :optional,
               name: :num,
               tag: 3,
               type: :int64
             }}
          end

          []
        ),
        (
          def field_def(:num_unit) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "numUnit",
               kind: {:scalar, 0},
               label: :optional,
               name: :num_unit,
               tag: 4,
               type: :int64
             }}
          end

          def field_def("numUnit") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "numUnit",
               kind: {:scalar, 0},
               label: :optional,
               name: :num_unit,
               tag: 4,
               type: :int64
             }}
          end

          def field_def("num_unit") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "numUnit",
               kind: {:scalar, 0},
               label: :optional,
               name: :num_unit,
               tag: 4,
               type: :int64
             }}
          end
        ),
        def field_def(_) do
          {:error, :no_such_field}
        end
      ]
    )

    (
      @spec unknown_fields(struct) :: [{non_neg_integer, Protox.Types.tag(), binary}]
      def unknown_fields(msg) do
        msg.__uf__
      end

      @spec unknown_fields_name() :: :__uf__
      def unknown_fields_name() do
        :__uf__
      end

      @spec clear_unknown_fields(struct) :: struct
      def clear_unknown_fields(msg) do
        struct!(msg, [{unknown_fields_name(), []}])
      end
    )

    (
      @spec required_fields() :: []
      def required_fields() do
        []
      end
    )

    (
      @spec syntax() :: atom()
      def syntax() do
        :proto3
      end
    )

    [
      @spec(default(atom) :: {:ok, boolean | integer | String.t() | float} | {:error, atom}),
      def default(:key) do
        {:ok, 0}
      end,
      def default(:str) do
        {:ok, 0}
      end,
      def default(:num) do
        {:ok, 0}
      end,
      def default(:num_unit) do
        {:ok, 0}
      end,
      def default(_) do
        {:error, :no_such_field}
      end
    ]

    (
      @spec file_options() :: struct()
      def file_options() do
        file_options = %{
          __struct__: Protox.Google.Protobuf.FileOptions,
          __uf__: [],
          cc_enable_arenas: nil,
          cc_generic_services: nil,
          csharp_namespace: nil,
          deprecated: nil,
          go_package: nil,
          java_generate_equals_and_hash: nil,
          java_generic_services: nil,
          java_multiple_files: nil,
          java_outer_classname: "ProfileProto",
          java_package: "com.google.perftools.profiles",
          java_string_check_utf8: nil,
          objc_class_prefix: nil,
          optimize_for: nil,
          php_class_prefix: nil,
          php_generic_services: nil,
          php_metadata_namespace: nil,
          php_namespace: nil,
          py_generic_services: nil,
          ruby_package: nil,
          swift_prefix: nil,
          uninterpreted_option: []
        }

        case function_exported?(Google.Protobuf.FileOptions, :decode!, 1) do
          true ->
            bytes =
              file_options
              |> Protox.Google.Protobuf.FileOptions.encode!()
              |> :binary.list_to_bin()

            apply(Google.Protobuf.FileOptions, :decode!, [bytes])

          false ->
            file_options
        end
      end
    )
  end,
  defmodule Perftools.Profiles.Line do
    @moduledoc false
    defstruct function_id: 0, line: 0, __uf__: []

    (
      (
        @spec encode(struct) :: {:ok, iodata} | {:error, any}
        def encode(msg) do
          try do
            {:ok, encode!(msg)}
          rescue
            e in [Protox.EncodingError, Protox.RequiredFieldsError] -> {:error, e}
          end
        end

        @spec encode!(struct) :: iodata | no_return
        def encode!(msg) do
          [] |> encode_function_id(msg) |> encode_line(msg) |> encode_unknown_fields(msg)
        end
      )

      []

      [
        defp encode_function_id(acc, msg) do
          try do
            if msg.function_id == 0 do
              acc
            else
              [acc, "\b", Protox.Encode.encode_uint64(msg.function_id)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:function_id, "invalid field value"),
                      __STACKTRACE__
          end
        end,
        defp encode_line(acc, msg) do
          try do
            if msg.line == 0 do
              acc
            else
              [acc, "\x10", Protox.Encode.encode_int64(msg.line)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:line, "invalid field value"), __STACKTRACE__
          end
        end
      ]

      defp encode_unknown_fields(acc, msg) do
        Enum.reduce(msg.__struct__.unknown_fields(msg), acc, fn {tag, wire_type, bytes}, acc ->
          case wire_type do
            0 ->
              [acc, Protox.Encode.make_key_bytes(tag, :int32), bytes]

            1 ->
              [acc, Protox.Encode.make_key_bytes(tag, :double), bytes]

            2 ->
              len_bytes = bytes |> byte_size() |> Protox.Varint.encode()
              [acc, Protox.Encode.make_key_bytes(tag, :packed), len_bytes, bytes]

            5 ->
              [acc, Protox.Encode.make_key_bytes(tag, :float), bytes]
          end
        end)
      end
    )

    (
      (
        @spec decode(binary) :: {:ok, struct} | {:error, any}
        def decode(bytes) do
          try do
            {:ok, decode!(bytes)}
          rescue
            e in [Protox.DecodingError, Protox.IllegalTagError, Protox.RequiredFieldsError] ->
              {:error, e}
          end
        end

        (
          @spec decode!(binary) :: struct | no_return
          def decode!(bytes) do
            parse_key_value(bytes, struct(Perftools.Profiles.Line))
          end
        )
      )

      (
        @spec parse_key_value(binary, struct) :: struct
        defp parse_key_value(<<>>, msg) do
          msg
        end

        defp parse_key_value(bytes, msg) do
          {field, rest} =
            case Protox.Decode.parse_key(bytes) do
              {0, _, _} ->
                raise %Protox.IllegalTagError{}

              {1, _, bytes} ->
                {value, rest} = Protox.Decode.parse_uint64(bytes)
                {[function_id: value], rest}

              {2, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[line: value], rest}

              {tag, wire_type, rest} ->
                {value, rest} = Protox.Decode.parse_unknown(tag, wire_type, rest)

                {[
                   {msg.__struct__.unknown_fields_name,
                    [value | msg.__struct__.unknown_fields(msg)]}
                 ], rest}
            end

          msg_updated = struct(msg, field)
          parse_key_value(rest, msg_updated)
        end
      )

      []
    )

    (
      @spec json_decode(iodata(), keyword()) :: {:ok, struct()} | {:error, any()}
      def json_decode(input, opts \\ []) do
        try do
          {:ok, json_decode!(input, opts)}
        rescue
          e in Protox.JsonDecodingError -> {:error, e}
        end
      end

      @spec json_decode!(iodata(), keyword()) :: struct() | no_return()
      def json_decode!(input, opts \\ []) do
        {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :decode)

        Protox.JsonDecode.decode!(
          input,
          Perftools.Profiles.Line,
          &json_library_wrapper.decode!(json_library, &1)
        )
      end

      @spec json_encode(struct(), keyword()) :: {:ok, iodata()} | {:error, any()}
      def json_encode(msg, opts \\ []) do
        try do
          {:ok, json_encode!(msg, opts)}
        rescue
          e in Protox.JsonEncodingError -> {:error, e}
        end
      end

      @spec json_encode!(struct(), keyword()) :: iodata() | no_return()
      def json_encode!(msg, opts \\ []) do
        {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :encode)
        Protox.JsonEncode.encode!(msg, &json_library_wrapper.encode!(json_library, &1))
      end
    )

    (
      @deprecated "Use fields_defs()/0 instead"
      @spec defs() :: %{
              required(non_neg_integer) => {atom, Protox.Types.kind(), Protox.Types.type()}
            }
      def defs() do
        %{1 => {:function_id, {:scalar, 0}, :uint64}, 2 => {:line, {:scalar, 0}, :int64}}
      end

      @deprecated "Use fields_defs()/0 instead"
      @spec defs_by_name() :: %{
              required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
            }
      def defs_by_name() do
        %{function_id: {1, {:scalar, 0}, :uint64}, line: {2, {:scalar, 0}, :int64}}
      end
    )

    (
      @spec fields_defs() :: list(Protox.Field.t())
      def fields_defs() do
        [
          %{
            __struct__: Protox.Field,
            json_name: "functionId",
            kind: {:scalar, 0},
            label: :optional,
            name: :function_id,
            tag: 1,
            type: :uint64
          },
          %{
            __struct__: Protox.Field,
            json_name: "line",
            kind: {:scalar, 0},
            label: :optional,
            name: :line,
            tag: 2,
            type: :int64
          }
        ]
      end

      [
        @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
        (
          def field_def(:function_id) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "functionId",
               kind: {:scalar, 0},
               label: :optional,
               name: :function_id,
               tag: 1,
               type: :uint64
             }}
          end

          def field_def("functionId") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "functionId",
               kind: {:scalar, 0},
               label: :optional,
               name: :function_id,
               tag: 1,
               type: :uint64
             }}
          end

          def field_def("function_id") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "functionId",
               kind: {:scalar, 0},
               label: :optional,
               name: :function_id,
               tag: 1,
               type: :uint64
             }}
          end
        ),
        (
          def field_def(:line) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "line",
               kind: {:scalar, 0},
               label: :optional,
               name: :line,
               tag: 2,
               type: :int64
             }}
          end

          def field_def("line") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "line",
               kind: {:scalar, 0},
               label: :optional,
               name: :line,
               tag: 2,
               type: :int64
             }}
          end

          []
        ),
        def field_def(_) do
          {:error, :no_such_field}
        end
      ]
    )

    (
      @spec unknown_fields(struct) :: [{non_neg_integer, Protox.Types.tag(), binary}]
      def unknown_fields(msg) do
        msg.__uf__
      end

      @spec unknown_fields_name() :: :__uf__
      def unknown_fields_name() do
        :__uf__
      end

      @spec clear_unknown_fields(struct) :: struct
      def clear_unknown_fields(msg) do
        struct!(msg, [{unknown_fields_name(), []}])
      end
    )

    (
      @spec required_fields() :: []
      def required_fields() do
        []
      end
    )

    (
      @spec syntax() :: atom()
      def syntax() do
        :proto3
      end
    )

    [
      @spec(default(atom) :: {:ok, boolean | integer | String.t() | float} | {:error, atom}),
      def default(:function_id) do
        {:ok, 0}
      end,
      def default(:line) do
        {:ok, 0}
      end,
      def default(_) do
        {:error, :no_such_field}
      end
    ]

    (
      @spec file_options() :: struct()
      def file_options() do
        file_options = %{
          __struct__: Protox.Google.Protobuf.FileOptions,
          __uf__: [],
          cc_enable_arenas: nil,
          cc_generic_services: nil,
          csharp_namespace: nil,
          deprecated: nil,
          go_package: nil,
          java_generate_equals_and_hash: nil,
          java_generic_services: nil,
          java_multiple_files: nil,
          java_outer_classname: "ProfileProto",
          java_package: "com.google.perftools.profiles",
          java_string_check_utf8: nil,
          objc_class_prefix: nil,
          optimize_for: nil,
          php_class_prefix: nil,
          php_generic_services: nil,
          php_metadata_namespace: nil,
          php_namespace: nil,
          py_generic_services: nil,
          ruby_package: nil,
          swift_prefix: nil,
          uninterpreted_option: []
        }

        case function_exported?(Google.Protobuf.FileOptions, :decode!, 1) do
          true ->
            bytes =
              file_options
              |> Protox.Google.Protobuf.FileOptions.encode!()
              |> :binary.list_to_bin()

            apply(Google.Protobuf.FileOptions, :decode!, [bytes])

          false ->
            file_options
        end
      end
    )
  end,
  defmodule Perftools.Profiles.Location do
    @moduledoc false
    defstruct id: 0, mapping_id: 0, address: 0, line: [], is_folded: false, __uf__: []

    (
      (
        @spec encode(struct) :: {:ok, iodata} | {:error, any}
        def encode(msg) do
          try do
            {:ok, encode!(msg)}
          rescue
            e in [Protox.EncodingError, Protox.RequiredFieldsError] -> {:error, e}
          end
        end

        @spec encode!(struct) :: iodata | no_return
        def encode!(msg) do
          []
          |> encode_id(msg)
          |> encode_mapping_id(msg)
          |> encode_address(msg)
          |> encode_line(msg)
          |> encode_is_folded(msg)
          |> encode_unknown_fields(msg)
        end
      )

      []

      [
        defp encode_id(acc, msg) do
          try do
            if msg.id == 0 do
              acc
            else
              [acc, "\b", Protox.Encode.encode_uint64(msg.id)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:id, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_mapping_id(acc, msg) do
          try do
            if msg.mapping_id == 0 do
              acc
            else
              [acc, "\x10", Protox.Encode.encode_uint64(msg.mapping_id)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:mapping_id, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_address(acc, msg) do
          try do
            if msg.address == 0 do
              acc
            else
              [acc, "\x18", Protox.Encode.encode_uint64(msg.address)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:address, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_line(acc, msg) do
          try do
            case msg.line do
              [] ->
                acc

              values ->
                [
                  acc,
                  Enum.reduce(values, [], fn value, acc ->
                    [acc, "\"", Protox.Encode.encode_message(value)]
                  end)
                ]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:line, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_is_folded(acc, msg) do
          try do
            if msg.is_folded == false do
              acc
            else
              [acc, "(", Protox.Encode.encode_bool(msg.is_folded)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:is_folded, "invalid field value"), __STACKTRACE__
          end
        end
      ]

      defp encode_unknown_fields(acc, msg) do
        Enum.reduce(msg.__struct__.unknown_fields(msg), acc, fn {tag, wire_type, bytes}, acc ->
          case wire_type do
            0 ->
              [acc, Protox.Encode.make_key_bytes(tag, :int32), bytes]

            1 ->
              [acc, Protox.Encode.make_key_bytes(tag, :double), bytes]

            2 ->
              len_bytes = bytes |> byte_size() |> Protox.Varint.encode()
              [acc, Protox.Encode.make_key_bytes(tag, :packed), len_bytes, bytes]

            5 ->
              [acc, Protox.Encode.make_key_bytes(tag, :float), bytes]
          end
        end)
      end
    )

    (
      (
        @spec decode(binary) :: {:ok, struct} | {:error, any}
        def decode(bytes) do
          try do
            {:ok, decode!(bytes)}
          rescue
            e in [Protox.DecodingError, Protox.IllegalTagError, Protox.RequiredFieldsError] ->
              {:error, e}
          end
        end

        (
          @spec decode!(binary) :: struct | no_return
          def decode!(bytes) do
            parse_key_value(bytes, struct(Perftools.Profiles.Location))
          end
        )
      )

      (
        @spec parse_key_value(binary, struct) :: struct
        defp parse_key_value(<<>>, msg) do
          msg
        end

        defp parse_key_value(bytes, msg) do
          {field, rest} =
            case Protox.Decode.parse_key(bytes) do
              {0, _, _} ->
                raise %Protox.IllegalTagError{}

              {1, _, bytes} ->
                {value, rest} = Protox.Decode.parse_uint64(bytes)
                {[id: value], rest}

              {2, _, bytes} ->
                {value, rest} = Protox.Decode.parse_uint64(bytes)
                {[mapping_id: value], rest}

              {3, _, bytes} ->
                {value, rest} = Protox.Decode.parse_uint64(bytes)
                {[address: value], rest}

              {4, _, bytes} ->
                {len, bytes} = Protox.Varint.decode(bytes)
                {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
                {[line: msg.line ++ [Perftools.Profiles.Line.decode!(delimited)]], rest}

              {5, _, bytes} ->
                {value, rest} = Protox.Decode.parse_bool(bytes)
                {[is_folded: value], rest}

              {tag, wire_type, rest} ->
                {value, rest} = Protox.Decode.parse_unknown(tag, wire_type, rest)

                {[
                   {msg.__struct__.unknown_fields_name,
                    [value | msg.__struct__.unknown_fields(msg)]}
                 ], rest}
            end

          msg_updated = struct(msg, field)
          parse_key_value(rest, msg_updated)
        end
      )

      []
    )

    (
      @spec json_decode(iodata(), keyword()) :: {:ok, struct()} | {:error, any()}
      def json_decode(input, opts \\ []) do
        try do
          {:ok, json_decode!(input, opts)}
        rescue
          e in Protox.JsonDecodingError -> {:error, e}
        end
      end

      @spec json_decode!(iodata(), keyword()) :: struct() | no_return()
      def json_decode!(input, opts \\ []) do
        {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :decode)

        Protox.JsonDecode.decode!(
          input,
          Perftools.Profiles.Location,
          &json_library_wrapper.decode!(json_library, &1)
        )
      end

      @spec json_encode(struct(), keyword()) :: {:ok, iodata()} | {:error, any()}
      def json_encode(msg, opts \\ []) do
        try do
          {:ok, json_encode!(msg, opts)}
        rescue
          e in Protox.JsonEncodingError -> {:error, e}
        end
      end

      @spec json_encode!(struct(), keyword()) :: iodata() | no_return()
      def json_encode!(msg, opts \\ []) do
        {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :encode)
        Protox.JsonEncode.encode!(msg, &json_library_wrapper.encode!(json_library, &1))
      end
    )

    (
      @deprecated "Use fields_defs()/0 instead"
      @spec defs() :: %{
              required(non_neg_integer) => {atom, Protox.Types.kind(), Protox.Types.type()}
            }
      def defs() do
        %{
          1 => {:id, {:scalar, 0}, :uint64},
          2 => {:mapping_id, {:scalar, 0}, :uint64},
          3 => {:address, {:scalar, 0}, :uint64},
          4 => {:line, :unpacked, {:message, Perftools.Profiles.Line}},
          5 => {:is_folded, {:scalar, false}, :bool}
        }
      end

      @deprecated "Use fields_defs()/0 instead"
      @spec defs_by_name() :: %{
              required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
            }
      def defs_by_name() do
        %{
          address: {3, {:scalar, 0}, :uint64},
          id: {1, {:scalar, 0}, :uint64},
          is_folded: {5, {:scalar, false}, :bool},
          line: {4, :unpacked, {:message, Perftools.Profiles.Line}},
          mapping_id: {2, {:scalar, 0}, :uint64}
        }
      end
    )

    (
      @spec fields_defs() :: list(Protox.Field.t())
      def fields_defs() do
        [
          %{
            __struct__: Protox.Field,
            json_name: "id",
            kind: {:scalar, 0},
            label: :optional,
            name: :id,
            tag: 1,
            type: :uint64
          },
          %{
            __struct__: Protox.Field,
            json_name: "mappingId",
            kind: {:scalar, 0},
            label: :optional,
            name: :mapping_id,
            tag: 2,
            type: :uint64
          },
          %{
            __struct__: Protox.Field,
            json_name: "address",
            kind: {:scalar, 0},
            label: :optional,
            name: :address,
            tag: 3,
            type: :uint64
          },
          %{
            __struct__: Protox.Field,
            json_name: "line",
            kind: :unpacked,
            label: :repeated,
            name: :line,
            tag: 4,
            type: {:message, Perftools.Profiles.Line}
          },
          %{
            __struct__: Protox.Field,
            json_name: "isFolded",
            kind: {:scalar, false},
            label: :optional,
            name: :is_folded,
            tag: 5,
            type: :bool
          }
        ]
      end

      [
        @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
        (
          def field_def(:id) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "id",
               kind: {:scalar, 0},
               label: :optional,
               name: :id,
               tag: 1,
               type: :uint64
             }}
          end

          def field_def("id") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "id",
               kind: {:scalar, 0},
               label: :optional,
               name: :id,
               tag: 1,
               type: :uint64
             }}
          end

          []
        ),
        (
          def field_def(:mapping_id) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "mappingId",
               kind: {:scalar, 0},
               label: :optional,
               name: :mapping_id,
               tag: 2,
               type: :uint64
             }}
          end

          def field_def("mappingId") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "mappingId",
               kind: {:scalar, 0},
               label: :optional,
               name: :mapping_id,
               tag: 2,
               type: :uint64
             }}
          end

          def field_def("mapping_id") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "mappingId",
               kind: {:scalar, 0},
               label: :optional,
               name: :mapping_id,
               tag: 2,
               type: :uint64
             }}
          end
        ),
        (
          def field_def(:address) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "address",
               kind: {:scalar, 0},
               label: :optional,
               name: :address,
               tag: 3,
               type: :uint64
             }}
          end

          def field_def("address") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "address",
               kind: {:scalar, 0},
               label: :optional,
               name: :address,
               tag: 3,
               type: :uint64
             }}
          end

          []
        ),
        (
          def field_def(:line) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "line",
               kind: :unpacked,
               label: :repeated,
               name: :line,
               tag: 4,
               type: {:message, Perftools.Profiles.Line}
             }}
          end

          def field_def("line") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "line",
               kind: :unpacked,
               label: :repeated,
               name: :line,
               tag: 4,
               type: {:message, Perftools.Profiles.Line}
             }}
          end

          []
        ),
        (
          def field_def(:is_folded) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "isFolded",
               kind: {:scalar, false},
               label: :optional,
               name: :is_folded,
               tag: 5,
               type: :bool
             }}
          end

          def field_def("isFolded") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "isFolded",
               kind: {:scalar, false},
               label: :optional,
               name: :is_folded,
               tag: 5,
               type: :bool
             }}
          end

          def field_def("is_folded") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "isFolded",
               kind: {:scalar, false},
               label: :optional,
               name: :is_folded,
               tag: 5,
               type: :bool
             }}
          end
        ),
        def field_def(_) do
          {:error, :no_such_field}
        end
      ]
    )

    (
      @spec unknown_fields(struct) :: [{non_neg_integer, Protox.Types.tag(), binary}]
      def unknown_fields(msg) do
        msg.__uf__
      end

      @spec unknown_fields_name() :: :__uf__
      def unknown_fields_name() do
        :__uf__
      end

      @spec clear_unknown_fields(struct) :: struct
      def clear_unknown_fields(msg) do
        struct!(msg, [{unknown_fields_name(), []}])
      end
    )

    (
      @spec required_fields() :: []
      def required_fields() do
        []
      end
    )

    (
      @spec syntax() :: atom()
      def syntax() do
        :proto3
      end
    )

    [
      @spec(default(atom) :: {:ok, boolean | integer | String.t() | float} | {:error, atom}),
      def default(:id) do
        {:ok, 0}
      end,
      def default(:mapping_id) do
        {:ok, 0}
      end,
      def default(:address) do
        {:ok, 0}
      end,
      def default(:line) do
        {:error, :no_default_value}
      end,
      def default(:is_folded) do
        {:ok, false}
      end,
      def default(_) do
        {:error, :no_such_field}
      end
    ]

    (
      @spec file_options() :: struct()
      def file_options() do
        file_options = %{
          __struct__: Protox.Google.Protobuf.FileOptions,
          __uf__: [],
          cc_enable_arenas: nil,
          cc_generic_services: nil,
          csharp_namespace: nil,
          deprecated: nil,
          go_package: nil,
          java_generate_equals_and_hash: nil,
          java_generic_services: nil,
          java_multiple_files: nil,
          java_outer_classname: "ProfileProto",
          java_package: "com.google.perftools.profiles",
          java_string_check_utf8: nil,
          objc_class_prefix: nil,
          optimize_for: nil,
          php_class_prefix: nil,
          php_generic_services: nil,
          php_metadata_namespace: nil,
          php_namespace: nil,
          py_generic_services: nil,
          ruby_package: nil,
          swift_prefix: nil,
          uninterpreted_option: []
        }

        case function_exported?(Google.Protobuf.FileOptions, :decode!, 1) do
          true ->
            bytes =
              file_options
              |> Protox.Google.Protobuf.FileOptions.encode!()
              |> :binary.list_to_bin()

            apply(Google.Protobuf.FileOptions, :decode!, [bytes])

          false ->
            file_options
        end
      end
    )
  end,
  defmodule Perftools.Profiles.Mapping do
    @moduledoc false
    defstruct id: 0,
              memory_start: 0,
              memory_limit: 0,
              file_offset: 0,
              filename: 0,
              build_id: 0,
              has_functions: false,
              has_filenames: false,
              has_line_numbers: false,
              has_inline_frames: false,
              __uf__: []

    (
      (
        @spec encode(struct) :: {:ok, iodata} | {:error, any}
        def encode(msg) do
          try do
            {:ok, encode!(msg)}
          rescue
            e in [Protox.EncodingError, Protox.RequiredFieldsError] -> {:error, e}
          end
        end

        @spec encode!(struct) :: iodata | no_return
        def encode!(msg) do
          []
          |> encode_id(msg)
          |> encode_memory_start(msg)
          |> encode_memory_limit(msg)
          |> encode_file_offset(msg)
          |> encode_filename(msg)
          |> encode_build_id(msg)
          |> encode_has_functions(msg)
          |> encode_has_filenames(msg)
          |> encode_has_line_numbers(msg)
          |> encode_has_inline_frames(msg)
          |> encode_unknown_fields(msg)
        end
      )

      []

      [
        defp encode_id(acc, msg) do
          try do
            if msg.id == 0 do
              acc
            else
              [acc, "\b", Protox.Encode.encode_uint64(msg.id)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:id, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_memory_start(acc, msg) do
          try do
            if msg.memory_start == 0 do
              acc
            else
              [acc, "\x10", Protox.Encode.encode_uint64(msg.memory_start)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:memory_start, "invalid field value"),
                      __STACKTRACE__
          end
        end,
        defp encode_memory_limit(acc, msg) do
          try do
            if msg.memory_limit == 0 do
              acc
            else
              [acc, "\x18", Protox.Encode.encode_uint64(msg.memory_limit)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:memory_limit, "invalid field value"),
                      __STACKTRACE__
          end
        end,
        defp encode_file_offset(acc, msg) do
          try do
            if msg.file_offset == 0 do
              acc
            else
              [acc, " ", Protox.Encode.encode_uint64(msg.file_offset)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:file_offset, "invalid field value"),
                      __STACKTRACE__
          end
        end,
        defp encode_filename(acc, msg) do
          try do
            if msg.filename == 0 do
              acc
            else
              [acc, "(", Protox.Encode.encode_int64(msg.filename)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:filename, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_build_id(acc, msg) do
          try do
            if msg.build_id == 0 do
              acc
            else
              [acc, "0", Protox.Encode.encode_int64(msg.build_id)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:build_id, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_has_functions(acc, msg) do
          try do
            if msg.has_functions == false do
              acc
            else
              [acc, "8", Protox.Encode.encode_bool(msg.has_functions)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:has_functions, "invalid field value"),
                      __STACKTRACE__
          end
        end,
        defp encode_has_filenames(acc, msg) do
          try do
            if msg.has_filenames == false do
              acc
            else
              [acc, "@", Protox.Encode.encode_bool(msg.has_filenames)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:has_filenames, "invalid field value"),
                      __STACKTRACE__
          end
        end,
        defp encode_has_line_numbers(acc, msg) do
          try do
            if msg.has_line_numbers == false do
              acc
            else
              [acc, "H", Protox.Encode.encode_bool(msg.has_line_numbers)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:has_line_numbers, "invalid field value"),
                      __STACKTRACE__
          end
        end,
        defp encode_has_inline_frames(acc, msg) do
          try do
            if msg.has_inline_frames == false do
              acc
            else
              [acc, "P", Protox.Encode.encode_bool(msg.has_inline_frames)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:has_inline_frames, "invalid field value"),
                      __STACKTRACE__
          end
        end
      ]

      defp encode_unknown_fields(acc, msg) do
        Enum.reduce(msg.__struct__.unknown_fields(msg), acc, fn {tag, wire_type, bytes}, acc ->
          case wire_type do
            0 ->
              [acc, Protox.Encode.make_key_bytes(tag, :int32), bytes]

            1 ->
              [acc, Protox.Encode.make_key_bytes(tag, :double), bytes]

            2 ->
              len_bytes = bytes |> byte_size() |> Protox.Varint.encode()
              [acc, Protox.Encode.make_key_bytes(tag, :packed), len_bytes, bytes]

            5 ->
              [acc, Protox.Encode.make_key_bytes(tag, :float), bytes]
          end
        end)
      end
    )

    (
      (
        @spec decode(binary) :: {:ok, struct} | {:error, any}
        def decode(bytes) do
          try do
            {:ok, decode!(bytes)}
          rescue
            e in [Protox.DecodingError, Protox.IllegalTagError, Protox.RequiredFieldsError] ->
              {:error, e}
          end
        end

        (
          @spec decode!(binary) :: struct | no_return
          def decode!(bytes) do
            parse_key_value(bytes, struct(Perftools.Profiles.Mapping))
          end
        )
      )

      (
        @spec parse_key_value(binary, struct) :: struct
        defp parse_key_value(<<>>, msg) do
          msg
        end

        defp parse_key_value(bytes, msg) do
          {field, rest} =
            case Protox.Decode.parse_key(bytes) do
              {0, _, _} ->
                raise %Protox.IllegalTagError{}

              {1, _, bytes} ->
                {value, rest} = Protox.Decode.parse_uint64(bytes)
                {[id: value], rest}

              {2, _, bytes} ->
                {value, rest} = Protox.Decode.parse_uint64(bytes)
                {[memory_start: value], rest}

              {3, _, bytes} ->
                {value, rest} = Protox.Decode.parse_uint64(bytes)
                {[memory_limit: value], rest}

              {4, _, bytes} ->
                {value, rest} = Protox.Decode.parse_uint64(bytes)
                {[file_offset: value], rest}

              {5, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[filename: value], rest}

              {6, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[build_id: value], rest}

              {7, _, bytes} ->
                {value, rest} = Protox.Decode.parse_bool(bytes)
                {[has_functions: value], rest}

              {8, _, bytes} ->
                {value, rest} = Protox.Decode.parse_bool(bytes)
                {[has_filenames: value], rest}

              {9, _, bytes} ->
                {value, rest} = Protox.Decode.parse_bool(bytes)
                {[has_line_numbers: value], rest}

              {10, _, bytes} ->
                {value, rest} = Protox.Decode.parse_bool(bytes)
                {[has_inline_frames: value], rest}

              {tag, wire_type, rest} ->
                {value, rest} = Protox.Decode.parse_unknown(tag, wire_type, rest)

                {[
                   {msg.__struct__.unknown_fields_name,
                    [value | msg.__struct__.unknown_fields(msg)]}
                 ], rest}
            end

          msg_updated = struct(msg, field)
          parse_key_value(rest, msg_updated)
        end
      )

      []
    )

    (
      @spec json_decode(iodata(), keyword()) :: {:ok, struct()} | {:error, any()}
      def json_decode(input, opts \\ []) do
        try do
          {:ok, json_decode!(input, opts)}
        rescue
          e in Protox.JsonDecodingError -> {:error, e}
        end
      end

      @spec json_decode!(iodata(), keyword()) :: struct() | no_return()
      def json_decode!(input, opts \\ []) do
        {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :decode)

        Protox.JsonDecode.decode!(
          input,
          Perftools.Profiles.Mapping,
          &json_library_wrapper.decode!(json_library, &1)
        )
      end

      @spec json_encode(struct(), keyword()) :: {:ok, iodata()} | {:error, any()}
      def json_encode(msg, opts \\ []) do
        try do
          {:ok, json_encode!(msg, opts)}
        rescue
          e in Protox.JsonEncodingError -> {:error, e}
        end
      end

      @spec json_encode!(struct(), keyword()) :: iodata() | no_return()
      def json_encode!(msg, opts \\ []) do
        {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :encode)
        Protox.JsonEncode.encode!(msg, &json_library_wrapper.encode!(json_library, &1))
      end
    )

    (
      @deprecated "Use fields_defs()/0 instead"
      @spec defs() :: %{
              required(non_neg_integer) => {atom, Protox.Types.kind(), Protox.Types.type()}
            }
      def defs() do
        %{
          1 => {:id, {:scalar, 0}, :uint64},
          2 => {:memory_start, {:scalar, 0}, :uint64},
          3 => {:memory_limit, {:scalar, 0}, :uint64},
          4 => {:file_offset, {:scalar, 0}, :uint64},
          5 => {:filename, {:scalar, 0}, :int64},
          6 => {:build_id, {:scalar, 0}, :int64},
          7 => {:has_functions, {:scalar, false}, :bool},
          8 => {:has_filenames, {:scalar, false}, :bool},
          9 => {:has_line_numbers, {:scalar, false}, :bool},
          10 => {:has_inline_frames, {:scalar, false}, :bool}
        }
      end

      @deprecated "Use fields_defs()/0 instead"
      @spec defs_by_name() :: %{
              required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
            }
      def defs_by_name() do
        %{
          build_id: {6, {:scalar, 0}, :int64},
          file_offset: {4, {:scalar, 0}, :uint64},
          filename: {5, {:scalar, 0}, :int64},
          has_filenames: {8, {:scalar, false}, :bool},
          has_functions: {7, {:scalar, false}, :bool},
          has_inline_frames: {10, {:scalar, false}, :bool},
          has_line_numbers: {9, {:scalar, false}, :bool},
          id: {1, {:scalar, 0}, :uint64},
          memory_limit: {3, {:scalar, 0}, :uint64},
          memory_start: {2, {:scalar, 0}, :uint64}
        }
      end
    )

    (
      @spec fields_defs() :: list(Protox.Field.t())
      def fields_defs() do
        [
          %{
            __struct__: Protox.Field,
            json_name: "id",
            kind: {:scalar, 0},
            label: :optional,
            name: :id,
            tag: 1,
            type: :uint64
          },
          %{
            __struct__: Protox.Field,
            json_name: "memoryStart",
            kind: {:scalar, 0},
            label: :optional,
            name: :memory_start,
            tag: 2,
            type: :uint64
          },
          %{
            __struct__: Protox.Field,
            json_name: "memoryLimit",
            kind: {:scalar, 0},
            label: :optional,
            name: :memory_limit,
            tag: 3,
            type: :uint64
          },
          %{
            __struct__: Protox.Field,
            json_name: "fileOffset",
            kind: {:scalar, 0},
            label: :optional,
            name: :file_offset,
            tag: 4,
            type: :uint64
          },
          %{
            __struct__: Protox.Field,
            json_name: "filename",
            kind: {:scalar, 0},
            label: :optional,
            name: :filename,
            tag: 5,
            type: :int64
          },
          %{
            __struct__: Protox.Field,
            json_name: "buildId",
            kind: {:scalar, 0},
            label: :optional,
            name: :build_id,
            tag: 6,
            type: :int64
          },
          %{
            __struct__: Protox.Field,
            json_name: "hasFunctions",
            kind: {:scalar, false},
            label: :optional,
            name: :has_functions,
            tag: 7,
            type: :bool
          },
          %{
            __struct__: Protox.Field,
            json_name: "hasFilenames",
            kind: {:scalar, false},
            label: :optional,
            name: :has_filenames,
            tag: 8,
            type: :bool
          },
          %{
            __struct__: Protox.Field,
            json_name: "hasLineNumbers",
            kind: {:scalar, false},
            label: :optional,
            name: :has_line_numbers,
            tag: 9,
            type: :bool
          },
          %{
            __struct__: Protox.Field,
            json_name: "hasInlineFrames",
            kind: {:scalar, false},
            label: :optional,
            name: :has_inline_frames,
            tag: 10,
            type: :bool
          }
        ]
      end

      [
        @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
        (
          def field_def(:id) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "id",
               kind: {:scalar, 0},
               label: :optional,
               name: :id,
               tag: 1,
               type: :uint64
             }}
          end

          def field_def("id") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "id",
               kind: {:scalar, 0},
               label: :optional,
               name: :id,
               tag: 1,
               type: :uint64
             }}
          end

          []
        ),
        (
          def field_def(:memory_start) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "memoryStart",
               kind: {:scalar, 0},
               label: :optional,
               name: :memory_start,
               tag: 2,
               type: :uint64
             }}
          end

          def field_def("memoryStart") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "memoryStart",
               kind: {:scalar, 0},
               label: :optional,
               name: :memory_start,
               tag: 2,
               type: :uint64
             }}
          end

          def field_def("memory_start") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "memoryStart",
               kind: {:scalar, 0},
               label: :optional,
               name: :memory_start,
               tag: 2,
               type: :uint64
             }}
          end
        ),
        (
          def field_def(:memory_limit) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "memoryLimit",
               kind: {:scalar, 0},
               label: :optional,
               name: :memory_limit,
               tag: 3,
               type: :uint64
             }}
          end

          def field_def("memoryLimit") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "memoryLimit",
               kind: {:scalar, 0},
               label: :optional,
               name: :memory_limit,
               tag: 3,
               type: :uint64
             }}
          end

          def field_def("memory_limit") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "memoryLimit",
               kind: {:scalar, 0},
               label: :optional,
               name: :memory_limit,
               tag: 3,
               type: :uint64
             }}
          end
        ),
        (
          def field_def(:file_offset) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "fileOffset",
               kind: {:scalar, 0},
               label: :optional,
               name: :file_offset,
               tag: 4,
               type: :uint64
             }}
          end

          def field_def("fileOffset") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "fileOffset",
               kind: {:scalar, 0},
               label: :optional,
               name: :file_offset,
               tag: 4,
               type: :uint64
             }}
          end

          def field_def("file_offset") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "fileOffset",
               kind: {:scalar, 0},
               label: :optional,
               name: :file_offset,
               tag: 4,
               type: :uint64
             }}
          end
        ),
        (
          def field_def(:filename) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "filename",
               kind: {:scalar, 0},
               label: :optional,
               name: :filename,
               tag: 5,
               type: :int64
             }}
          end

          def field_def("filename") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "filename",
               kind: {:scalar, 0},
               label: :optional,
               name: :filename,
               tag: 5,
               type: :int64
             }}
          end

          []
        ),
        (
          def field_def(:build_id) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "buildId",
               kind: {:scalar, 0},
               label: :optional,
               name: :build_id,
               tag: 6,
               type: :int64
             }}
          end

          def field_def("buildId") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "buildId",
               kind: {:scalar, 0},
               label: :optional,
               name: :build_id,
               tag: 6,
               type: :int64
             }}
          end

          def field_def("build_id") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "buildId",
               kind: {:scalar, 0},
               label: :optional,
               name: :build_id,
               tag: 6,
               type: :int64
             }}
          end
        ),
        (
          def field_def(:has_functions) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "hasFunctions",
               kind: {:scalar, false},
               label: :optional,
               name: :has_functions,
               tag: 7,
               type: :bool
             }}
          end

          def field_def("hasFunctions") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "hasFunctions",
               kind: {:scalar, false},
               label: :optional,
               name: :has_functions,
               tag: 7,
               type: :bool
             }}
          end

          def field_def("has_functions") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "hasFunctions",
               kind: {:scalar, false},
               label: :optional,
               name: :has_functions,
               tag: 7,
               type: :bool
             }}
          end
        ),
        (
          def field_def(:has_filenames) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "hasFilenames",
               kind: {:scalar, false},
               label: :optional,
               name: :has_filenames,
               tag: 8,
               type: :bool
             }}
          end

          def field_def("hasFilenames") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "hasFilenames",
               kind: {:scalar, false},
               label: :optional,
               name: :has_filenames,
               tag: 8,
               type: :bool
             }}
          end

          def field_def("has_filenames") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "hasFilenames",
               kind: {:scalar, false},
               label: :optional,
               name: :has_filenames,
               tag: 8,
               type: :bool
             }}
          end
        ),
        (
          def field_def(:has_line_numbers) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "hasLineNumbers",
               kind: {:scalar, false},
               label: :optional,
               name: :has_line_numbers,
               tag: 9,
               type: :bool
             }}
          end

          def field_def("hasLineNumbers") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "hasLineNumbers",
               kind: {:scalar, false},
               label: :optional,
               name: :has_line_numbers,
               tag: 9,
               type: :bool
             }}
          end

          def field_def("has_line_numbers") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "hasLineNumbers",
               kind: {:scalar, false},
               label: :optional,
               name: :has_line_numbers,
               tag: 9,
               type: :bool
             }}
          end
        ),
        (
          def field_def(:has_inline_frames) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "hasInlineFrames",
               kind: {:scalar, false},
               label: :optional,
               name: :has_inline_frames,
               tag: 10,
               type: :bool
             }}
          end

          def field_def("hasInlineFrames") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "hasInlineFrames",
               kind: {:scalar, false},
               label: :optional,
               name: :has_inline_frames,
               tag: 10,
               type: :bool
             }}
          end

          def field_def("has_inline_frames") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "hasInlineFrames",
               kind: {:scalar, false},
               label: :optional,
               name: :has_inline_frames,
               tag: 10,
               type: :bool
             }}
          end
        ),
        def field_def(_) do
          {:error, :no_such_field}
        end
      ]
    )

    (
      @spec unknown_fields(struct) :: [{non_neg_integer, Protox.Types.tag(), binary}]
      def unknown_fields(msg) do
        msg.__uf__
      end

      @spec unknown_fields_name() :: :__uf__
      def unknown_fields_name() do
        :__uf__
      end

      @spec clear_unknown_fields(struct) :: struct
      def clear_unknown_fields(msg) do
        struct!(msg, [{unknown_fields_name(), []}])
      end
    )

    (
      @spec required_fields() :: []
      def required_fields() do
        []
      end
    )

    (
      @spec syntax() :: atom()
      def syntax() do
        :proto3
      end
    )

    [
      @spec(default(atom) :: {:ok, boolean | integer | String.t() | float} | {:error, atom}),
      def default(:id) do
        {:ok, 0}
      end,
      def default(:memory_start) do
        {:ok, 0}
      end,
      def default(:memory_limit) do
        {:ok, 0}
      end,
      def default(:file_offset) do
        {:ok, 0}
      end,
      def default(:filename) do
        {:ok, 0}
      end,
      def default(:build_id) do
        {:ok, 0}
      end,
      def default(:has_functions) do
        {:ok, false}
      end,
      def default(:has_filenames) do
        {:ok, false}
      end,
      def default(:has_line_numbers) do
        {:ok, false}
      end,
      def default(:has_inline_frames) do
        {:ok, false}
      end,
      def default(_) do
        {:error, :no_such_field}
      end
    ]

    (
      @spec file_options() :: struct()
      def file_options() do
        file_options = %{
          __struct__: Protox.Google.Protobuf.FileOptions,
          __uf__: [],
          cc_enable_arenas: nil,
          cc_generic_services: nil,
          csharp_namespace: nil,
          deprecated: nil,
          go_package: nil,
          java_generate_equals_and_hash: nil,
          java_generic_services: nil,
          java_multiple_files: nil,
          java_outer_classname: "ProfileProto",
          java_package: "com.google.perftools.profiles",
          java_string_check_utf8: nil,
          objc_class_prefix: nil,
          optimize_for: nil,
          php_class_prefix: nil,
          php_generic_services: nil,
          php_metadata_namespace: nil,
          php_namespace: nil,
          py_generic_services: nil,
          ruby_package: nil,
          swift_prefix: nil,
          uninterpreted_option: []
        }

        case function_exported?(Google.Protobuf.FileOptions, :decode!, 1) do
          true ->
            bytes =
              file_options
              |> Protox.Google.Protobuf.FileOptions.encode!()
              |> :binary.list_to_bin()

            apply(Google.Protobuf.FileOptions, :decode!, [bytes])

          false ->
            file_options
        end
      end
    )
  end,
  defmodule Perftools.Profiles.Profile do
    @moduledoc false
    defstruct sample_type: [],
              sample: [],
              mapping: [],
              location: [],
              function: [],
              string_table: [],
              drop_frames: 0,
              keep_frames: 0,
              time_nanos: 0,
              duration_nanos: 0,
              period_type: nil,
              period: 0,
              comment: [],
              default_sample_type: 0,
              __uf__: []

    (
      (
        @spec encode(struct) :: {:ok, iodata} | {:error, any}
        def encode(msg) do
          try do
            {:ok, encode!(msg)}
          rescue
            e in [Protox.EncodingError, Protox.RequiredFieldsError] -> {:error, e}
          end
        end

        @spec encode!(struct) :: iodata | no_return
        def encode!(msg) do
          []
          |> encode_sample_type(msg)
          |> encode_sample(msg)
          |> encode_mapping(msg)
          |> encode_location(msg)
          |> encode_function(msg)
          |> encode_string_table(msg)
          |> encode_drop_frames(msg)
          |> encode_keep_frames(msg)
          |> encode_time_nanos(msg)
          |> encode_duration_nanos(msg)
          |> encode_period_type(msg)
          |> encode_period(msg)
          |> encode_comment(msg)
          |> encode_default_sample_type(msg)
          |> encode_unknown_fields(msg)
        end
      )

      []

      [
        defp encode_sample_type(acc, msg) do
          try do
            case msg.sample_type do
              [] ->
                acc

              values ->
                [
                  acc,
                  Enum.reduce(values, [], fn value, acc ->
                    [acc, "\n", Protox.Encode.encode_message(value)]
                  end)
                ]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:sample_type, "invalid field value"),
                      __STACKTRACE__
          end
        end,
        defp encode_sample(acc, msg) do
          try do
            case msg.sample do
              [] ->
                acc

              values ->
                [
                  acc,
                  Enum.reduce(values, [], fn value, acc ->
                    [acc, "\x12", Protox.Encode.encode_message(value)]
                  end)
                ]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:sample, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_mapping(acc, msg) do
          try do
            case msg.mapping do
              [] ->
                acc

              values ->
                [
                  acc,
                  Enum.reduce(values, [], fn value, acc ->
                    [acc, "\x1A", Protox.Encode.encode_message(value)]
                  end)
                ]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:mapping, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_location(acc, msg) do
          try do
            case msg.location do
              [] ->
                acc

              values ->
                [
                  acc,
                  Enum.reduce(values, [], fn value, acc ->
                    [acc, "\"", Protox.Encode.encode_message(value)]
                  end)
                ]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:location, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_function(acc, msg) do
          try do
            case msg.function do
              [] ->
                acc

              values ->
                [
                  acc,
                  Enum.reduce(values, [], fn value, acc ->
                    [acc, "*", Protox.Encode.encode_message(value)]
                  end)
                ]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:function, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_string_table(acc, msg) do
          try do
            case msg.string_table do
              [] ->
                acc

              values ->
                [
                  acc,
                  Enum.reduce(values, [], fn value, acc ->
                    [acc, "2", Protox.Encode.encode_string(value)]
                  end)
                ]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:string_table, "invalid field value"),
                      __STACKTRACE__
          end
        end,
        defp encode_drop_frames(acc, msg) do
          try do
            if msg.drop_frames == 0 do
              acc
            else
              [acc, "8", Protox.Encode.encode_int64(msg.drop_frames)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:drop_frames, "invalid field value"),
                      __STACKTRACE__
          end
        end,
        defp encode_keep_frames(acc, msg) do
          try do
            if msg.keep_frames == 0 do
              acc
            else
              [acc, "@", Protox.Encode.encode_int64(msg.keep_frames)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:keep_frames, "invalid field value"),
                      __STACKTRACE__
          end
        end,
        defp encode_time_nanos(acc, msg) do
          try do
            if msg.time_nanos == 0 do
              acc
            else
              [acc, "H", Protox.Encode.encode_int64(msg.time_nanos)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:time_nanos, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_duration_nanos(acc, msg) do
          try do
            if msg.duration_nanos == 0 do
              acc
            else
              [acc, "P", Protox.Encode.encode_int64(msg.duration_nanos)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:duration_nanos, "invalid field value"),
                      __STACKTRACE__
          end
        end,
        defp encode_period_type(acc, msg) do
          try do
            if msg.period_type == nil do
              acc
            else
              [acc, "Z", Protox.Encode.encode_message(msg.period_type)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:period_type, "invalid field value"),
                      __STACKTRACE__
          end
        end,
        defp encode_period(acc, msg) do
          try do
            if msg.period == 0 do
              acc
            else
              [acc, "`", Protox.Encode.encode_int64(msg.period)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:period, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_comment(acc, msg) do
          try do
            case msg.comment do
              [] ->
                acc

              values ->
                [
                  acc,
                  "j",
                  (
                    {bytes, len} =
                      Enum.reduce(values, {[], 0}, fn value, {acc, len} ->
                        value_bytes = :binary.list_to_bin([Protox.Encode.encode_int64(value)])
                        {[acc, value_bytes], len + byte_size(value_bytes)}
                      end)

                    [Protox.Varint.encode(len), bytes]
                  )
                ]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:comment, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_default_sample_type(acc, msg) do
          try do
            if msg.default_sample_type == 0 do
              acc
            else
              [acc, "p", Protox.Encode.encode_int64(msg.default_sample_type)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:default_sample_type, "invalid field value"),
                      __STACKTRACE__
          end
        end
      ]

      defp encode_unknown_fields(acc, msg) do
        Enum.reduce(msg.__struct__.unknown_fields(msg), acc, fn {tag, wire_type, bytes}, acc ->
          case wire_type do
            0 ->
              [acc, Protox.Encode.make_key_bytes(tag, :int32), bytes]

            1 ->
              [acc, Protox.Encode.make_key_bytes(tag, :double), bytes]

            2 ->
              len_bytes = bytes |> byte_size() |> Protox.Varint.encode()
              [acc, Protox.Encode.make_key_bytes(tag, :packed), len_bytes, bytes]

            5 ->
              [acc, Protox.Encode.make_key_bytes(tag, :float), bytes]
          end
        end)
      end
    )

    (
      (
        @spec decode(binary) :: {:ok, struct} | {:error, any}
        def decode(bytes) do
          try do
            {:ok, decode!(bytes)}
          rescue
            e in [Protox.DecodingError, Protox.IllegalTagError, Protox.RequiredFieldsError] ->
              {:error, e}
          end
        end

        (
          @spec decode!(binary) :: struct | no_return
          def decode!(bytes) do
            parse_key_value(bytes, struct(Perftools.Profiles.Profile))
          end
        )
      )

      (
        @spec parse_key_value(binary, struct) :: struct
        defp parse_key_value(<<>>, msg) do
          msg
        end

        defp parse_key_value(bytes, msg) do
          {field, rest} =
            case Protox.Decode.parse_key(bytes) do
              {0, _, _} ->
                raise %Protox.IllegalTagError{}

              {1, _, bytes} ->
                {len, bytes} = Protox.Varint.decode(bytes)
                {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

                {[
                   sample_type:
                     msg.sample_type ++ [Perftools.Profiles.ValueType.decode!(delimited)]
                 ], rest}

              {2, _, bytes} ->
                {len, bytes} = Protox.Varint.decode(bytes)
                {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
                {[sample: msg.sample ++ [Perftools.Profiles.Sample.decode!(delimited)]], rest}

              {3, _, bytes} ->
                {len, bytes} = Protox.Varint.decode(bytes)
                {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
                {[mapping: msg.mapping ++ [Perftools.Profiles.Mapping.decode!(delimited)]], rest}

              {4, _, bytes} ->
                {len, bytes} = Protox.Varint.decode(bytes)
                {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

                {[location: msg.location ++ [Perftools.Profiles.Location.decode!(delimited)]],
                 rest}

              {5, _, bytes} ->
                {len, bytes} = Protox.Varint.decode(bytes)
                {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

                {[function: msg.function ++ [Perftools.Profiles.Function.decode!(delimited)]],
                 rest}

              {6, _, bytes} ->
                {len, bytes} = Protox.Varint.decode(bytes)
                {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
                {[string_table: msg.string_table ++ [delimited]], rest}

              {7, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[drop_frames: value], rest}

              {8, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[keep_frames: value], rest}

              {9, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[time_nanos: value], rest}

              {10, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[duration_nanos: value], rest}

              {11, _, bytes} ->
                {len, bytes} = Protox.Varint.decode(bytes)
                {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

                {[
                   period_type:
                     Protox.MergeMessage.merge(
                       msg.period_type,
                       Perftools.Profiles.ValueType.decode!(delimited)
                     )
                 ], rest}

              {12, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[period: value], rest}

              {13, 2, bytes} ->
                {len, bytes} = Protox.Varint.decode(bytes)
                {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

                {[comment: msg.comment ++ Protox.Decode.parse_repeated_int64([], delimited)],
                 rest}

              {13, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[comment: msg.comment ++ [value]], rest}

              {14, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[default_sample_type: value], rest}

              {tag, wire_type, rest} ->
                {value, rest} = Protox.Decode.parse_unknown(tag, wire_type, rest)

                {[
                   {msg.__struct__.unknown_fields_name,
                    [value | msg.__struct__.unknown_fields(msg)]}
                 ], rest}
            end

          msg_updated = struct(msg, field)
          parse_key_value(rest, msg_updated)
        end
      )

      []
    )

    (
      @spec json_decode(iodata(), keyword()) :: {:ok, struct()} | {:error, any()}
      def json_decode(input, opts \\ []) do
        try do
          {:ok, json_decode!(input, opts)}
        rescue
          e in Protox.JsonDecodingError -> {:error, e}
        end
      end

      @spec json_decode!(iodata(), keyword()) :: struct() | no_return()
      def json_decode!(input, opts \\ []) do
        {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :decode)

        Protox.JsonDecode.decode!(
          input,
          Perftools.Profiles.Profile,
          &json_library_wrapper.decode!(json_library, &1)
        )
      end

      @spec json_encode(struct(), keyword()) :: {:ok, iodata()} | {:error, any()}
      def json_encode(msg, opts \\ []) do
        try do
          {:ok, json_encode!(msg, opts)}
        rescue
          e in Protox.JsonEncodingError -> {:error, e}
        end
      end

      @spec json_encode!(struct(), keyword()) :: iodata() | no_return()
      def json_encode!(msg, opts \\ []) do
        {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :encode)
        Protox.JsonEncode.encode!(msg, &json_library_wrapper.encode!(json_library, &1))
      end
    )

    (
      @deprecated "Use fields_defs()/0 instead"
      @spec defs() :: %{
              required(non_neg_integer) => {atom, Protox.Types.kind(), Protox.Types.type()}
            }
      def defs() do
        %{
          1 => {:sample_type, :unpacked, {:message, Perftools.Profiles.ValueType}},
          2 => {:sample, :unpacked, {:message, Perftools.Profiles.Sample}},
          3 => {:mapping, :unpacked, {:message, Perftools.Profiles.Mapping}},
          4 => {:location, :unpacked, {:message, Perftools.Profiles.Location}},
          5 => {:function, :unpacked, {:message, Perftools.Profiles.Function}},
          6 => {:string_table, :unpacked, :string},
          7 => {:drop_frames, {:scalar, 0}, :int64},
          8 => {:keep_frames, {:scalar, 0}, :int64},
          9 => {:time_nanos, {:scalar, 0}, :int64},
          10 => {:duration_nanos, {:scalar, 0}, :int64},
          11 => {:period_type, {:scalar, nil}, {:message, Perftools.Profiles.ValueType}},
          12 => {:period, {:scalar, 0}, :int64},
          13 => {:comment, :packed, :int64},
          14 => {:default_sample_type, {:scalar, 0}, :int64}
        }
      end

      @deprecated "Use fields_defs()/0 instead"
      @spec defs_by_name() :: %{
              required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
            }
      def defs_by_name() do
        %{
          comment: {13, :packed, :int64},
          default_sample_type: {14, {:scalar, 0}, :int64},
          drop_frames: {7, {:scalar, 0}, :int64},
          duration_nanos: {10, {:scalar, 0}, :int64},
          function: {5, :unpacked, {:message, Perftools.Profiles.Function}},
          keep_frames: {8, {:scalar, 0}, :int64},
          location: {4, :unpacked, {:message, Perftools.Profiles.Location}},
          mapping: {3, :unpacked, {:message, Perftools.Profiles.Mapping}},
          period: {12, {:scalar, 0}, :int64},
          period_type: {11, {:scalar, nil}, {:message, Perftools.Profiles.ValueType}},
          sample: {2, :unpacked, {:message, Perftools.Profiles.Sample}},
          sample_type: {1, :unpacked, {:message, Perftools.Profiles.ValueType}},
          string_table: {6, :unpacked, :string},
          time_nanos: {9, {:scalar, 0}, :int64}
        }
      end
    )

    (
      @spec fields_defs() :: list(Protox.Field.t())
      def fields_defs() do
        [
          %{
            __struct__: Protox.Field,
            json_name: "sampleType",
            kind: :unpacked,
            label: :repeated,
            name: :sample_type,
            tag: 1,
            type: {:message, Perftools.Profiles.ValueType}
          },
          %{
            __struct__: Protox.Field,
            json_name: "sample",
            kind: :unpacked,
            label: :repeated,
            name: :sample,
            tag: 2,
            type: {:message, Perftools.Profiles.Sample}
          },
          %{
            __struct__: Protox.Field,
            json_name: "mapping",
            kind: :unpacked,
            label: :repeated,
            name: :mapping,
            tag: 3,
            type: {:message, Perftools.Profiles.Mapping}
          },
          %{
            __struct__: Protox.Field,
            json_name: "location",
            kind: :unpacked,
            label: :repeated,
            name: :location,
            tag: 4,
            type: {:message, Perftools.Profiles.Location}
          },
          %{
            __struct__: Protox.Field,
            json_name: "function",
            kind: :unpacked,
            label: :repeated,
            name: :function,
            tag: 5,
            type: {:message, Perftools.Profiles.Function}
          },
          %{
            __struct__: Protox.Field,
            json_name: "stringTable",
            kind: :unpacked,
            label: :repeated,
            name: :string_table,
            tag: 6,
            type: :string
          },
          %{
            __struct__: Protox.Field,
            json_name: "dropFrames",
            kind: {:scalar, 0},
            label: :optional,
            name: :drop_frames,
            tag: 7,
            type: :int64
          },
          %{
            __struct__: Protox.Field,
            json_name: "keepFrames",
            kind: {:scalar, 0},
            label: :optional,
            name: :keep_frames,
            tag: 8,
            type: :int64
          },
          %{
            __struct__: Protox.Field,
            json_name: "timeNanos",
            kind: {:scalar, 0},
            label: :optional,
            name: :time_nanos,
            tag: 9,
            type: :int64
          },
          %{
            __struct__: Protox.Field,
            json_name: "durationNanos",
            kind: {:scalar, 0},
            label: :optional,
            name: :duration_nanos,
            tag: 10,
            type: :int64
          },
          %{
            __struct__: Protox.Field,
            json_name: "periodType",
            kind: {:scalar, nil},
            label: :optional,
            name: :period_type,
            tag: 11,
            type: {:message, Perftools.Profiles.ValueType}
          },
          %{
            __struct__: Protox.Field,
            json_name: "period",
            kind: {:scalar, 0},
            label: :optional,
            name: :period,
            tag: 12,
            type: :int64
          },
          %{
            __struct__: Protox.Field,
            json_name: "comment",
            kind: :packed,
            label: :repeated,
            name: :comment,
            tag: 13,
            type: :int64
          },
          %{
            __struct__: Protox.Field,
            json_name: "defaultSampleType",
            kind: {:scalar, 0},
            label: :optional,
            name: :default_sample_type,
            tag: 14,
            type: :int64
          }
        ]
      end

      [
        @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
        (
          def field_def(:sample_type) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "sampleType",
               kind: :unpacked,
               label: :repeated,
               name: :sample_type,
               tag: 1,
               type: {:message, Perftools.Profiles.ValueType}
             }}
          end

          def field_def("sampleType") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "sampleType",
               kind: :unpacked,
               label: :repeated,
               name: :sample_type,
               tag: 1,
               type: {:message, Perftools.Profiles.ValueType}
             }}
          end

          def field_def("sample_type") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "sampleType",
               kind: :unpacked,
               label: :repeated,
               name: :sample_type,
               tag: 1,
               type: {:message, Perftools.Profiles.ValueType}
             }}
          end
        ),
        (
          def field_def(:sample) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "sample",
               kind: :unpacked,
               label: :repeated,
               name: :sample,
               tag: 2,
               type: {:message, Perftools.Profiles.Sample}
             }}
          end

          def field_def("sample") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "sample",
               kind: :unpacked,
               label: :repeated,
               name: :sample,
               tag: 2,
               type: {:message, Perftools.Profiles.Sample}
             }}
          end

          []
        ),
        (
          def field_def(:mapping) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "mapping",
               kind: :unpacked,
               label: :repeated,
               name: :mapping,
               tag: 3,
               type: {:message, Perftools.Profiles.Mapping}
             }}
          end

          def field_def("mapping") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "mapping",
               kind: :unpacked,
               label: :repeated,
               name: :mapping,
               tag: 3,
               type: {:message, Perftools.Profiles.Mapping}
             }}
          end

          []
        ),
        (
          def field_def(:location) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "location",
               kind: :unpacked,
               label: :repeated,
               name: :location,
               tag: 4,
               type: {:message, Perftools.Profiles.Location}
             }}
          end

          def field_def("location") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "location",
               kind: :unpacked,
               label: :repeated,
               name: :location,
               tag: 4,
               type: {:message, Perftools.Profiles.Location}
             }}
          end

          []
        ),
        (
          def field_def(:function) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "function",
               kind: :unpacked,
               label: :repeated,
               name: :function,
               tag: 5,
               type: {:message, Perftools.Profiles.Function}
             }}
          end

          def field_def("function") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "function",
               kind: :unpacked,
               label: :repeated,
               name: :function,
               tag: 5,
               type: {:message, Perftools.Profiles.Function}
             }}
          end

          []
        ),
        (
          def field_def(:string_table) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "stringTable",
               kind: :unpacked,
               label: :repeated,
               name: :string_table,
               tag: 6,
               type: :string
             }}
          end

          def field_def("stringTable") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "stringTable",
               kind: :unpacked,
               label: :repeated,
               name: :string_table,
               tag: 6,
               type: :string
             }}
          end

          def field_def("string_table") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "stringTable",
               kind: :unpacked,
               label: :repeated,
               name: :string_table,
               tag: 6,
               type: :string
             }}
          end
        ),
        (
          def field_def(:drop_frames) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "dropFrames",
               kind: {:scalar, 0},
               label: :optional,
               name: :drop_frames,
               tag: 7,
               type: :int64
             }}
          end

          def field_def("dropFrames") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "dropFrames",
               kind: {:scalar, 0},
               label: :optional,
               name: :drop_frames,
               tag: 7,
               type: :int64
             }}
          end

          def field_def("drop_frames") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "dropFrames",
               kind: {:scalar, 0},
               label: :optional,
               name: :drop_frames,
               tag: 7,
               type: :int64
             }}
          end
        ),
        (
          def field_def(:keep_frames) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "keepFrames",
               kind: {:scalar, 0},
               label: :optional,
               name: :keep_frames,
               tag: 8,
               type: :int64
             }}
          end

          def field_def("keepFrames") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "keepFrames",
               kind: {:scalar, 0},
               label: :optional,
               name: :keep_frames,
               tag: 8,
               type: :int64
             }}
          end

          def field_def("keep_frames") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "keepFrames",
               kind: {:scalar, 0},
               label: :optional,
               name: :keep_frames,
               tag: 8,
               type: :int64
             }}
          end
        ),
        (
          def field_def(:time_nanos) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "timeNanos",
               kind: {:scalar, 0},
               label: :optional,
               name: :time_nanos,
               tag: 9,
               type: :int64
             }}
          end

          def field_def("timeNanos") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "timeNanos",
               kind: {:scalar, 0},
               label: :optional,
               name: :time_nanos,
               tag: 9,
               type: :int64
             }}
          end

          def field_def("time_nanos") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "timeNanos",
               kind: {:scalar, 0},
               label: :optional,
               name: :time_nanos,
               tag: 9,
               type: :int64
             }}
          end
        ),
        (
          def field_def(:duration_nanos) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "durationNanos",
               kind: {:scalar, 0},
               label: :optional,
               name: :duration_nanos,
               tag: 10,
               type: :int64
             }}
          end

          def field_def("durationNanos") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "durationNanos",
               kind: {:scalar, 0},
               label: :optional,
               name: :duration_nanos,
               tag: 10,
               type: :int64
             }}
          end

          def field_def("duration_nanos") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "durationNanos",
               kind: {:scalar, 0},
               label: :optional,
               name: :duration_nanos,
               tag: 10,
               type: :int64
             }}
          end
        ),
        (
          def field_def(:period_type) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "periodType",
               kind: {:scalar, nil},
               label: :optional,
               name: :period_type,
               tag: 11,
               type: {:message, Perftools.Profiles.ValueType}
             }}
          end

          def field_def("periodType") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "periodType",
               kind: {:scalar, nil},
               label: :optional,
               name: :period_type,
               tag: 11,
               type: {:message, Perftools.Profiles.ValueType}
             }}
          end

          def field_def("period_type") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "periodType",
               kind: {:scalar, nil},
               label: :optional,
               name: :period_type,
               tag: 11,
               type: {:message, Perftools.Profiles.ValueType}
             }}
          end
        ),
        (
          def field_def(:period) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "period",
               kind: {:scalar, 0},
               label: :optional,
               name: :period,
               tag: 12,
               type: :int64
             }}
          end

          def field_def("period") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "period",
               kind: {:scalar, 0},
               label: :optional,
               name: :period,
               tag: 12,
               type: :int64
             }}
          end

          []
        ),
        (
          def field_def(:comment) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "comment",
               kind: :packed,
               label: :repeated,
               name: :comment,
               tag: 13,
               type: :int64
             }}
          end

          def field_def("comment") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "comment",
               kind: :packed,
               label: :repeated,
               name: :comment,
               tag: 13,
               type: :int64
             }}
          end

          []
        ),
        (
          def field_def(:default_sample_type) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "defaultSampleType",
               kind: {:scalar, 0},
               label: :optional,
               name: :default_sample_type,
               tag: 14,
               type: :int64
             }}
          end

          def field_def("defaultSampleType") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "defaultSampleType",
               kind: {:scalar, 0},
               label: :optional,
               name: :default_sample_type,
               tag: 14,
               type: :int64
             }}
          end

          def field_def("default_sample_type") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "defaultSampleType",
               kind: {:scalar, 0},
               label: :optional,
               name: :default_sample_type,
               tag: 14,
               type: :int64
             }}
          end
        ),
        def field_def(_) do
          {:error, :no_such_field}
        end
      ]
    )

    (
      @spec unknown_fields(struct) :: [{non_neg_integer, Protox.Types.tag(), binary}]
      def unknown_fields(msg) do
        msg.__uf__
      end

      @spec unknown_fields_name() :: :__uf__
      def unknown_fields_name() do
        :__uf__
      end

      @spec clear_unknown_fields(struct) :: struct
      def clear_unknown_fields(msg) do
        struct!(msg, [{unknown_fields_name(), []}])
      end
    )

    (
      @spec required_fields() :: []
      def required_fields() do
        []
      end
    )

    (
      @spec syntax() :: atom()
      def syntax() do
        :proto3
      end
    )

    [
      @spec(default(atom) :: {:ok, boolean | integer | String.t() | float} | {:error, atom}),
      def default(:sample_type) do
        {:error, :no_default_value}
      end,
      def default(:sample) do
        {:error, :no_default_value}
      end,
      def default(:mapping) do
        {:error, :no_default_value}
      end,
      def default(:location) do
        {:error, :no_default_value}
      end,
      def default(:function) do
        {:error, :no_default_value}
      end,
      def default(:string_table) do
        {:error, :no_default_value}
      end,
      def default(:drop_frames) do
        {:ok, 0}
      end,
      def default(:keep_frames) do
        {:ok, 0}
      end,
      def default(:time_nanos) do
        {:ok, 0}
      end,
      def default(:duration_nanos) do
        {:ok, 0}
      end,
      def default(:period_type) do
        {:ok, nil}
      end,
      def default(:period) do
        {:ok, 0}
      end,
      def default(:comment) do
        {:error, :no_default_value}
      end,
      def default(:default_sample_type) do
        {:ok, 0}
      end,
      def default(_) do
        {:error, :no_such_field}
      end
    ]

    (
      @spec file_options() :: struct()
      def file_options() do
        file_options = %{
          __struct__: Protox.Google.Protobuf.FileOptions,
          __uf__: [],
          cc_enable_arenas: nil,
          cc_generic_services: nil,
          csharp_namespace: nil,
          deprecated: nil,
          go_package: nil,
          java_generate_equals_and_hash: nil,
          java_generic_services: nil,
          java_multiple_files: nil,
          java_outer_classname: "ProfileProto",
          java_package: "com.google.perftools.profiles",
          java_string_check_utf8: nil,
          objc_class_prefix: nil,
          optimize_for: nil,
          php_class_prefix: nil,
          php_generic_services: nil,
          php_metadata_namespace: nil,
          php_namespace: nil,
          py_generic_services: nil,
          ruby_package: nil,
          swift_prefix: nil,
          uninterpreted_option: []
        }

        case function_exported?(Google.Protobuf.FileOptions, :decode!, 1) do
          true ->
            bytes =
              file_options
              |> Protox.Google.Protobuf.FileOptions.encode!()
              |> :binary.list_to_bin()

            apply(Google.Protobuf.FileOptions, :decode!, [bytes])

          false ->
            file_options
        end
      end
    )
  end,
  defmodule Perftools.Profiles.Sample do
    @moduledoc false
    defstruct location_id: [], value: [], label: [], __uf__: []

    (
      (
        @spec encode(struct) :: {:ok, iodata} | {:error, any}
        def encode(msg) do
          try do
            {:ok, encode!(msg)}
          rescue
            e in [Protox.EncodingError, Protox.RequiredFieldsError] -> {:error, e}
          end
        end

        @spec encode!(struct) :: iodata | no_return
        def encode!(msg) do
          []
          |> encode_location_id(msg)
          |> encode_value(msg)
          |> encode_label(msg)
          |> encode_unknown_fields(msg)
        end
      )

      []

      [
        defp encode_location_id(acc, msg) do
          try do
            case msg.location_id do
              [] ->
                acc

              values ->
                [
                  acc,
                  "\n",
                  (
                    {bytes, len} =
                      Enum.reduce(values, {[], 0}, fn value, {acc, len} ->
                        value_bytes = :binary.list_to_bin([Protox.Encode.encode_uint64(value)])
                        {[acc, value_bytes], len + byte_size(value_bytes)}
                      end)

                    [Protox.Varint.encode(len), bytes]
                  )
                ]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:location_id, "invalid field value"),
                      __STACKTRACE__
          end
        end,
        defp encode_value(acc, msg) do
          try do
            case msg.value do
              [] ->
                acc

              values ->
                [
                  acc,
                  "\x12",
                  (
                    {bytes, len} =
                      Enum.reduce(values, {[], 0}, fn value, {acc, len} ->
                        value_bytes = :binary.list_to_bin([Protox.Encode.encode_int64(value)])
                        {[acc, value_bytes], len + byte_size(value_bytes)}
                      end)

                    [Protox.Varint.encode(len), bytes]
                  )
                ]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:value, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_label(acc, msg) do
          try do
            case msg.label do
              [] ->
                acc

              values ->
                [
                  acc,
                  Enum.reduce(values, [], fn value, acc ->
                    [acc, "\x1A", Protox.Encode.encode_message(value)]
                  end)
                ]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:label, "invalid field value"), __STACKTRACE__
          end
        end
      ]

      defp encode_unknown_fields(acc, msg) do
        Enum.reduce(msg.__struct__.unknown_fields(msg), acc, fn {tag, wire_type, bytes}, acc ->
          case wire_type do
            0 ->
              [acc, Protox.Encode.make_key_bytes(tag, :int32), bytes]

            1 ->
              [acc, Protox.Encode.make_key_bytes(tag, :double), bytes]

            2 ->
              len_bytes = bytes |> byte_size() |> Protox.Varint.encode()
              [acc, Protox.Encode.make_key_bytes(tag, :packed), len_bytes, bytes]

            5 ->
              [acc, Protox.Encode.make_key_bytes(tag, :float), bytes]
          end
        end)
      end
    )

    (
      (
        @spec decode(binary) :: {:ok, struct} | {:error, any}
        def decode(bytes) do
          try do
            {:ok, decode!(bytes)}
          rescue
            e in [Protox.DecodingError, Protox.IllegalTagError, Protox.RequiredFieldsError] ->
              {:error, e}
          end
        end

        (
          @spec decode!(binary) :: struct | no_return
          def decode!(bytes) do
            parse_key_value(bytes, struct(Perftools.Profiles.Sample))
          end
        )
      )

      (
        @spec parse_key_value(binary, struct) :: struct
        defp parse_key_value(<<>>, msg) do
          msg
        end

        defp parse_key_value(bytes, msg) do
          {field, rest} =
            case Protox.Decode.parse_key(bytes) do
              {0, _, _} ->
                raise %Protox.IllegalTagError{}

              {1, 2, bytes} ->
                {len, bytes} = Protox.Varint.decode(bytes)
                {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

                {[
                   location_id:
                     msg.location_id ++ Protox.Decode.parse_repeated_uint64([], delimited)
                 ], rest}

              {1, _, bytes} ->
                {value, rest} = Protox.Decode.parse_uint64(bytes)
                {[location_id: msg.location_id ++ [value]], rest}

              {2, 2, bytes} ->
                {len, bytes} = Protox.Varint.decode(bytes)
                {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
                {[value: msg.value ++ Protox.Decode.parse_repeated_int64([], delimited)], rest}

              {2, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[value: msg.value ++ [value]], rest}

              {3, _, bytes} ->
                {len, bytes} = Protox.Varint.decode(bytes)
                {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
                {[label: msg.label ++ [Perftools.Profiles.Label.decode!(delimited)]], rest}

              {tag, wire_type, rest} ->
                {value, rest} = Protox.Decode.parse_unknown(tag, wire_type, rest)

                {[
                   {msg.__struct__.unknown_fields_name,
                    [value | msg.__struct__.unknown_fields(msg)]}
                 ], rest}
            end

          msg_updated = struct(msg, field)
          parse_key_value(rest, msg_updated)
        end
      )

      []
    )

    (
      @spec json_decode(iodata(), keyword()) :: {:ok, struct()} | {:error, any()}
      def json_decode(input, opts \\ []) do
        try do
          {:ok, json_decode!(input, opts)}
        rescue
          e in Protox.JsonDecodingError -> {:error, e}
        end
      end

      @spec json_decode!(iodata(), keyword()) :: struct() | no_return()
      def json_decode!(input, opts \\ []) do
        {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :decode)

        Protox.JsonDecode.decode!(
          input,
          Perftools.Profiles.Sample,
          &json_library_wrapper.decode!(json_library, &1)
        )
      end

      @spec json_encode(struct(), keyword()) :: {:ok, iodata()} | {:error, any()}
      def json_encode(msg, opts \\ []) do
        try do
          {:ok, json_encode!(msg, opts)}
        rescue
          e in Protox.JsonEncodingError -> {:error, e}
        end
      end

      @spec json_encode!(struct(), keyword()) :: iodata() | no_return()
      def json_encode!(msg, opts \\ []) do
        {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :encode)
        Protox.JsonEncode.encode!(msg, &json_library_wrapper.encode!(json_library, &1))
      end
    )

    (
      @deprecated "Use fields_defs()/0 instead"
      @spec defs() :: %{
              required(non_neg_integer) => {atom, Protox.Types.kind(), Protox.Types.type()}
            }
      def defs() do
        %{
          1 => {:location_id, :packed, :uint64},
          2 => {:value, :packed, :int64},
          3 => {:label, :unpacked, {:message, Perftools.Profiles.Label}}
        }
      end

      @deprecated "Use fields_defs()/0 instead"
      @spec defs_by_name() :: %{
              required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
            }
      def defs_by_name() do
        %{
          label: {3, :unpacked, {:message, Perftools.Profiles.Label}},
          location_id: {1, :packed, :uint64},
          value: {2, :packed, :int64}
        }
      end
    )

    (
      @spec fields_defs() :: list(Protox.Field.t())
      def fields_defs() do
        [
          %{
            __struct__: Protox.Field,
            json_name: "locationId",
            kind: :packed,
            label: :repeated,
            name: :location_id,
            tag: 1,
            type: :uint64
          },
          %{
            __struct__: Protox.Field,
            json_name: "value",
            kind: :packed,
            label: :repeated,
            name: :value,
            tag: 2,
            type: :int64
          },
          %{
            __struct__: Protox.Field,
            json_name: "label",
            kind: :unpacked,
            label: :repeated,
            name: :label,
            tag: 3,
            type: {:message, Perftools.Profiles.Label}
          }
        ]
      end

      [
        @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
        (
          def field_def(:location_id) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "locationId",
               kind: :packed,
               label: :repeated,
               name: :location_id,
               tag: 1,
               type: :uint64
             }}
          end

          def field_def("locationId") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "locationId",
               kind: :packed,
               label: :repeated,
               name: :location_id,
               tag: 1,
               type: :uint64
             }}
          end

          def field_def("location_id") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "locationId",
               kind: :packed,
               label: :repeated,
               name: :location_id,
               tag: 1,
               type: :uint64
             }}
          end
        ),
        (
          def field_def(:value) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "value",
               kind: :packed,
               label: :repeated,
               name: :value,
               tag: 2,
               type: :int64
             }}
          end

          def field_def("value") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "value",
               kind: :packed,
               label: :repeated,
               name: :value,
               tag: 2,
               type: :int64
             }}
          end

          []
        ),
        (
          def field_def(:label) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "label",
               kind: :unpacked,
               label: :repeated,
               name: :label,
               tag: 3,
               type: {:message, Perftools.Profiles.Label}
             }}
          end

          def field_def("label") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "label",
               kind: :unpacked,
               label: :repeated,
               name: :label,
               tag: 3,
               type: {:message, Perftools.Profiles.Label}
             }}
          end

          []
        ),
        def field_def(_) do
          {:error, :no_such_field}
        end
      ]
    )

    (
      @spec unknown_fields(struct) :: [{non_neg_integer, Protox.Types.tag(), binary}]
      def unknown_fields(msg) do
        msg.__uf__
      end

      @spec unknown_fields_name() :: :__uf__
      def unknown_fields_name() do
        :__uf__
      end

      @spec clear_unknown_fields(struct) :: struct
      def clear_unknown_fields(msg) do
        struct!(msg, [{unknown_fields_name(), []}])
      end
    )

    (
      @spec required_fields() :: []
      def required_fields() do
        []
      end
    )

    (
      @spec syntax() :: atom()
      def syntax() do
        :proto3
      end
    )

    [
      @spec(default(atom) :: {:ok, boolean | integer | String.t() | float} | {:error, atom}),
      def default(:location_id) do
        {:error, :no_default_value}
      end,
      def default(:value) do
        {:error, :no_default_value}
      end,
      def default(:label) do
        {:error, :no_default_value}
      end,
      def default(_) do
        {:error, :no_such_field}
      end
    ]

    (
      @spec file_options() :: struct()
      def file_options() do
        file_options = %{
          __struct__: Protox.Google.Protobuf.FileOptions,
          __uf__: [],
          cc_enable_arenas: nil,
          cc_generic_services: nil,
          csharp_namespace: nil,
          deprecated: nil,
          go_package: nil,
          java_generate_equals_and_hash: nil,
          java_generic_services: nil,
          java_multiple_files: nil,
          java_outer_classname: "ProfileProto",
          java_package: "com.google.perftools.profiles",
          java_string_check_utf8: nil,
          objc_class_prefix: nil,
          optimize_for: nil,
          php_class_prefix: nil,
          php_generic_services: nil,
          php_metadata_namespace: nil,
          php_namespace: nil,
          py_generic_services: nil,
          ruby_package: nil,
          swift_prefix: nil,
          uninterpreted_option: []
        }

        case function_exported?(Google.Protobuf.FileOptions, :decode!, 1) do
          true ->
            bytes =
              file_options
              |> Protox.Google.Protobuf.FileOptions.encode!()
              |> :binary.list_to_bin()

            apply(Google.Protobuf.FileOptions, :decode!, [bytes])

          false ->
            file_options
        end
      end
    )
  end,
  defmodule Perftools.Profiles.ValueType do
    @moduledoc false
    defstruct type: 0, unit: 0, __uf__: []

    (
      (
        @spec encode(struct) :: {:ok, iodata} | {:error, any}
        def encode(msg) do
          try do
            {:ok, encode!(msg)}
          rescue
            e in [Protox.EncodingError, Protox.RequiredFieldsError] -> {:error, e}
          end
        end

        @spec encode!(struct) :: iodata | no_return
        def encode!(msg) do
          [] |> encode_type(msg) |> encode_unit(msg) |> encode_unknown_fields(msg)
        end
      )

      []

      [
        defp encode_type(acc, msg) do
          try do
            if msg.type == 0 do
              acc
            else
              [acc, "\b", Protox.Encode.encode_int64(msg.type)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:type, "invalid field value"), __STACKTRACE__
          end
        end,
        defp encode_unit(acc, msg) do
          try do
            if msg.unit == 0 do
              acc
            else
              [acc, "\x10", Protox.Encode.encode_int64(msg.unit)]
            end
          rescue
            ArgumentError ->
              reraise Protox.EncodingError.new(:unit, "invalid field value"), __STACKTRACE__
          end
        end
      ]

      defp encode_unknown_fields(acc, msg) do
        Enum.reduce(msg.__struct__.unknown_fields(msg), acc, fn {tag, wire_type, bytes}, acc ->
          case wire_type do
            0 ->
              [acc, Protox.Encode.make_key_bytes(tag, :int32), bytes]

            1 ->
              [acc, Protox.Encode.make_key_bytes(tag, :double), bytes]

            2 ->
              len_bytes = bytes |> byte_size() |> Protox.Varint.encode()
              [acc, Protox.Encode.make_key_bytes(tag, :packed), len_bytes, bytes]

            5 ->
              [acc, Protox.Encode.make_key_bytes(tag, :float), bytes]
          end
        end)
      end
    )

    (
      (
        @spec decode(binary) :: {:ok, struct} | {:error, any}
        def decode(bytes) do
          try do
            {:ok, decode!(bytes)}
          rescue
            e in [Protox.DecodingError, Protox.IllegalTagError, Protox.RequiredFieldsError] ->
              {:error, e}
          end
        end

        (
          @spec decode!(binary) :: struct | no_return
          def decode!(bytes) do
            parse_key_value(bytes, struct(Perftools.Profiles.ValueType))
          end
        )
      )

      (
        @spec parse_key_value(binary, struct) :: struct
        defp parse_key_value(<<>>, msg) do
          msg
        end

        defp parse_key_value(bytes, msg) do
          {field, rest} =
            case Protox.Decode.parse_key(bytes) do
              {0, _, _} ->
                raise %Protox.IllegalTagError{}

              {1, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[type: value], rest}

              {2, _, bytes} ->
                {value, rest} = Protox.Decode.parse_int64(bytes)
                {[unit: value], rest}

              {tag, wire_type, rest} ->
                {value, rest} = Protox.Decode.parse_unknown(tag, wire_type, rest)

                {[
                   {msg.__struct__.unknown_fields_name,
                    [value | msg.__struct__.unknown_fields(msg)]}
                 ], rest}
            end

          msg_updated = struct(msg, field)
          parse_key_value(rest, msg_updated)
        end
      )

      []
    )

    (
      @spec json_decode(iodata(), keyword()) :: {:ok, struct()} | {:error, any()}
      def json_decode(input, opts \\ []) do
        try do
          {:ok, json_decode!(input, opts)}
        rescue
          e in Protox.JsonDecodingError -> {:error, e}
        end
      end

      @spec json_decode!(iodata(), keyword()) :: struct() | no_return()
      def json_decode!(input, opts \\ []) do
        {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :decode)

        Protox.JsonDecode.decode!(
          input,
          Perftools.Profiles.ValueType,
          &json_library_wrapper.decode!(json_library, &1)
        )
      end

      @spec json_encode(struct(), keyword()) :: {:ok, iodata()} | {:error, any()}
      def json_encode(msg, opts \\ []) do
        try do
          {:ok, json_encode!(msg, opts)}
        rescue
          e in Protox.JsonEncodingError -> {:error, e}
        end
      end

      @spec json_encode!(struct(), keyword()) :: iodata() | no_return()
      def json_encode!(msg, opts \\ []) do
        {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :encode)
        Protox.JsonEncode.encode!(msg, &json_library_wrapper.encode!(json_library, &1))
      end
    )

    (
      @deprecated "Use fields_defs()/0 instead"
      @spec defs() :: %{
              required(non_neg_integer) => {atom, Protox.Types.kind(), Protox.Types.type()}
            }
      def defs() do
        %{1 => {:type, {:scalar, 0}, :int64}, 2 => {:unit, {:scalar, 0}, :int64}}
      end

      @deprecated "Use fields_defs()/0 instead"
      @spec defs_by_name() :: %{
              required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
            }
      def defs_by_name() do
        %{type: {1, {:scalar, 0}, :int64}, unit: {2, {:scalar, 0}, :int64}}
      end
    )

    (
      @spec fields_defs() :: list(Protox.Field.t())
      def fields_defs() do
        [
          %{
            __struct__: Protox.Field,
            json_name: "type",
            kind: {:scalar, 0},
            label: :optional,
            name: :type,
            tag: 1,
            type: :int64
          },
          %{
            __struct__: Protox.Field,
            json_name: "unit",
            kind: {:scalar, 0},
            label: :optional,
            name: :unit,
            tag: 2,
            type: :int64
          }
        ]
      end

      [
        @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
        (
          def field_def(:type) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "type",
               kind: {:scalar, 0},
               label: :optional,
               name: :type,
               tag: 1,
               type: :int64
             }}
          end

          def field_def("type") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "type",
               kind: {:scalar, 0},
               label: :optional,
               name: :type,
               tag: 1,
               type: :int64
             }}
          end

          []
        ),
        (
          def field_def(:unit) do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "unit",
               kind: {:scalar, 0},
               label: :optional,
               name: :unit,
               tag: 2,
               type: :int64
             }}
          end

          def field_def("unit") do
            {:ok,
             %{
               __struct__: Protox.Field,
               json_name: "unit",
               kind: {:scalar, 0},
               label: :optional,
               name: :unit,
               tag: 2,
               type: :int64
             }}
          end

          []
        ),
        def field_def(_) do
          {:error, :no_such_field}
        end
      ]
    )

    (
      @spec unknown_fields(struct) :: [{non_neg_integer, Protox.Types.tag(), binary}]
      def unknown_fields(msg) do
        msg.__uf__
      end

      @spec unknown_fields_name() :: :__uf__
      def unknown_fields_name() do
        :__uf__
      end

      @spec clear_unknown_fields(struct) :: struct
      def clear_unknown_fields(msg) do
        struct!(msg, [{unknown_fields_name(), []}])
      end
    )

    (
      @spec required_fields() :: []
      def required_fields() do
        []
      end
    )

    (
      @spec syntax() :: atom()
      def syntax() do
        :proto3
      end
    )

    [
      @spec(default(atom) :: {:ok, boolean | integer | String.t() | float} | {:error, atom}),
      def default(:type) do
        {:ok, 0}
      end,
      def default(:unit) do
        {:ok, 0}
      end,
      def default(_) do
        {:error, :no_such_field}
      end
    ]

    (
      @spec file_options() :: struct()
      def file_options() do
        file_options = %{
          __struct__: Protox.Google.Protobuf.FileOptions,
          __uf__: [],
          cc_enable_arenas: nil,
          cc_generic_services: nil,
          csharp_namespace: nil,
          deprecated: nil,
          go_package: nil,
          java_generate_equals_and_hash: nil,
          java_generic_services: nil,
          java_multiple_files: nil,
          java_outer_classname: "ProfileProto",
          java_package: "com.google.perftools.profiles",
          java_string_check_utf8: nil,
          objc_class_prefix: nil,
          optimize_for: nil,
          php_class_prefix: nil,
          php_generic_services: nil,
          php_metadata_namespace: nil,
          php_namespace: nil,
          py_generic_services: nil,
          ruby_package: nil,
          swift_prefix: nil,
          uninterpreted_option: []
        }

        case function_exported?(Google.Protobuf.FileOptions, :decode!, 1) do
          true ->
            bytes =
              file_options
              |> Protox.Google.Protobuf.FileOptions.encode!()
              |> :binary.list_to_bin()

            apply(Google.Protobuf.FileOptions, :decode!, [bytes])

          false ->
            file_options
        end
      end
    )
  end
]
