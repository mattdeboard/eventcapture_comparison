defmodule Eventcapture.App do
  use Application.Behaviour

  def start(_type, _args) do
    Eventcapture.Sup.start_link
  end
end

defmodule Eventcapture.Sup do
  use Supervisor.Behaviour

  def start_link do
    :supervisor.start_link({ :local, __MODULE__ }, __MODULE__, [])
  end

  def init([]) do
    tree = [ worker(Eventcapture.DBConn, []) ]
    supervise(tree, strategy: :one_for_all)
  end
end

defmodule Eventcapture do
  use Application.Behaviour
end
