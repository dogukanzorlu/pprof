defmodule Pprof.Router do
  use Plug.Router
  use Plug.ErrorHandler

  plug(Plug.Parsers, parsers: [:urlencoded, :multipart], pass: ["text/*"])

  plug(Plug.Static,
    at: "./priv/static",
    from: "./priv/static",
    gzip: true
  )

  plug(:match)
  plug(:dispatch)

  get "/pprof" do
    send_resp(conn, 200, "Welcome")
  end

  get "/debug/pprof/profile" do
    duration = conn.params["seconds"]
    pid = conn.params["pid"]
    type = conn.params["type"]

    msec = if duration == nil, do: 3000, else: String.to_integer(conn.params["seconds"]) * 1000

    {reply, res} = GenServer.call(Pprof.Servers.Profile, {:profile, type, pid, msec}, msec + 1000)

    case reply do
      :ok ->
        resp = Pprof.Builder.Build.builder(msec)
        status = 200

        conn
        |> put_resp_header("Content-Disposition", "attachment; filename=profile.pb.gz")
        |> put_resp_header("Content-Type", "application/octet-stream")
        |> put_resp_header("X-Content-Type-Options", "nosniff")
        |> send_resp(status, resp)

      _ ->
        resp = res
        status = 500

        conn
        |> send_resp(status, resp)
    end
  end

  match _ do
    send_resp(conn, 404, "Oops!")
  end

  @impl Plug.ErrorHandler
  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    send_resp(conn, conn.status, "Something went wrong")
  end
end
