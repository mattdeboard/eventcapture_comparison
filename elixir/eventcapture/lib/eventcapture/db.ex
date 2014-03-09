defmodule Eventcapture.DBConn do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres

  def url do
    "ecto://eventcaptureuser:postgres@localhost:5432/event"
  end
end

