defmodule CurrentCurrency.Application do
  @moduledoc false

  alias CurrentCurrency.Router

  use Application

  def start(_type, _args) do
    children = [
      Plug.Adapters.Cowboy2.child_spec(
        scheme: :http,
        plug: Router,
        options: [port: 4001]
      )
    ]

    opts = [strategy: :one_for_one, name: CurrentCurrency.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
