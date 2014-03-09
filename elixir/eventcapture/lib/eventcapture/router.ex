defmodule Eventcapture.Router do
  use Phoenix.Router, 
    port: 3000

  get "/", Eventcapture.Controllers.Pages, :index, as: :page
  post "/capture", Eventcapture.Controllers.Events, :create
end
