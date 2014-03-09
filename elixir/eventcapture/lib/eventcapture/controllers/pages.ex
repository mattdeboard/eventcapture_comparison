defmodule Eventcapture.Controllers.Pages do
  use Phoenix.Controller
  
  def index(conn) do
    html conn, "It works!"
  end
end

defmodule Eventcapture.Controllers.Events do
  use Phoenix.Controller

  def create(conn) do
    conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.URLENCODED],
      limit: 10_000_000)
    [{"event_type", event_type}, {"ext_ref", ext_ref}, {"user_ref", user_ref},
        {"data", data}] = conn.params
    query(event_type, ext_ref, user_ref, data)
    text conn, ""
  end

  def query(event_type, ext_ref, user_ref, data) do
    Ecto.Adapters.Postgres.query(Eventcapture.DBConn, "select insert_eventlog($1, $2, $3, $4)", [event_type, ext_ref, user_ref, data])
  end
end

