defmodule Http.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Http.Adapter, plug: CurrentTime, port: 8080}
    ]

    opts = [strategy: :one_for_one, name: Http.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
